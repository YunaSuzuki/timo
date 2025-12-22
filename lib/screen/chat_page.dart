import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timo/components/chat_input_widget.dart';
import 'package:timo/constants.dart';

class ChatPage extends StatefulWidget {
  final String partnerId;
  final String partnerEmail;
  final String partnerUsername;

  const ChatPage({
    Key? key,
    required this.partnerId,
    required this.partnerEmail,
    required this.partnerUsername,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final TextEditingController _controller = TextEditingController();
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
    }
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

    return Scaffold(
      appBar: AppBar(title: Text(widget.partnerUsername, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
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

                      final String? text = msg.data().toString().contains('text')
                          ? msg['text']
                          : null;

                      final String? imageUrl = msg.data().toString().contains('imageUrl')
                          ? msg['imageUrl']
                          : null;

                      final hasImage = imageUrl != null && imageUrl.isNotEmpty;
                      final hasText = text != null && text.trim().isNotEmpty;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          padding: hasImage ? EdgeInsets.zero : const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: hasImage
                                ? Colors.transparent
                                : isMe
                                ? blue
                                : Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: (!isMe && !hasImage)
                                ? Border.all(color: Colors.black12, width: 0.5)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              /// 画像
                              if (hasImage)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl!,
                                    width: 200,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SizedBox(
                                        width: 200,
                                        height: 150,
                                        child: Center(child: CircularProgressIndicator()),
                                      );
                                    },
                                    errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image),
                                  ),
                                ),

                              /// テキスト
                              if (hasText)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    text!,
                                    style: isMe
                                        ? appTextStyle(color: Colors.white)
                                        : appTextStyle(
                                      color: greyDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // メッセージ入力欄
            ChatInputWidget(partnerId: widget.partnerId, partnerEmail: widget.partnerEmail,),
          ],
        ),
      ),
    );
  }
}