import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final String partnerId;
  final String partnerEmail;

  const ChatPage({
    Key? key,
    required this.partnerId,
    required this.partnerEmail,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String chatId;
  late final DocumentReference chatDocRef;

  @override
  void initState() {
    super.initState();
    final currentUserId = _auth.currentUser!.uid;

    // chatIdを一意に作成
    chatId = currentUserId.compareTo(widget.partnerId) <= 0
        ? '${currentUserId}_${widget.partnerId}'
        : '${widget.partnerId}_${currentUserId}';

    // ドキュメント参照を作成
    chatDocRef = FirebaseFirestore.instance.collection('chats').doc(chatId);

    // 初回作成（存在しない場合のみ）
    _createChatIfNotExists([currentUserId, widget.partnerId]);
  }

  // チャット作成（存在しない場合のみ）
  Future<void> _createChatIfNotExists(List<String> memberIds) async {
    final snapshot = await chatDocRef.get();
    if (!snapshot.exists) {
      await chatDocRef.set({
        'members': memberIds,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 👇 空のチャットに最初のダミーメッセージを追加しておく（オプション）
      await chatDocRef.collection('messages').add({
        'text': '',
        'senderId': 'system',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // メッセージ送信
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final messagesRef = chatDocRef.collection('messages').doc();
    await messagesRef.set({
      'text': text.trim(),
      'senderId': _auth.currentUser!.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // メッセージ取得ストリーム
  Stream<QuerySnapshot> getMessages() {
    return chatDocRef
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text(widget.partnerEmail)),
      body: SafeArea(
        child: Column(
          children: [
            // メッセージ一覧
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: chatDocRef
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('エラー: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('メッセージはまだありません'));
                  }

                  final docs = snapshot.data!.docs;
                  final currentUserId = _auth.currentUser!.uid;

                  return ListView.builder(
                    reverse: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final msg = docs[index];
                      final isMe = msg['senderId'] == currentUserId;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(msg['text']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // メッセージ入力欄
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'input message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _controller.text;
                      if (text.trim().isEmpty) return;
                      sendMessage(text);
                      _controller.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}