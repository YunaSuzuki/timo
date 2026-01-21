import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timo/constants.dart';

class ChatInputWidget extends StatefulWidget {
  final String partnerId;
  final String partnerEmail;

  const ChatInputWidget({
    Key? key,
    required this.partnerId,
    required this.partnerEmail,
  }) : super(key: key);

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final _controller = TextEditingController();
  final _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String chatId;
  late final DocumentReference chatDocRef;

  File? _selectedImage;
  bool isSending = false;

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

  /// 📷 画像選択
  Future<void> pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  //Firebase Storageに画像アップロード
  Future<String?> uploadImage(File image) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('$uid-${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await ref.putFile(image);

      if (uploadTask.state == TaskState.success) {
        return await ref.getDownloadURL();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('画像アップロード失敗: $e');
      return null;
    }
  }

  //  メッセージ送信
  Future<void> sendMessage() async {
    if (_controller.text.isEmpty && _selectedImage == null) return;

    setState(() => isSending = true);

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await uploadImage(_selectedImage!);
    }

    await chatDocRef.collection('messages').add({
      'text': _controller.text,
      'imageUrl': imageUrl,
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': Timestamp.now(),
    });

    _controller.clear();
    setState(() {
      _selectedImage = null;
      isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🖼 画像プレビュー
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() => _selectedImage = null);
                      },
                    ),
                  ),
                ],
              ),
            ),

          /// ⌨️ 入力欄
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                /// TextField
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      hintText: 'message',
                      filled: true,
                      fillColor: Colors.blueGrey[50],

                      /// TextField内の左側に画像アイコン
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.image_outlined, color: greyDark,),
                        onPressed: pickImage,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                /// 送信ボタン
                IconButton(
                  icon: isSending
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send, color: greyDark),
                  onPressed: isSending ? null : sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}