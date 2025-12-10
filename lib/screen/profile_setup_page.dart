import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timo/screen/main_page.dart';

class ProfileSetupPage extends StatefulWidget {
  final String uid;

  const ProfileSetupPage({required this.uid});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール登録')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'ユーザーネーム'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: '自己紹介'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('登録する'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .set({
                  'username': usernameController.text,
                  'bio': bioController.text,
                  'createdAt': FieldValue.serverTimestamp(),
                });

                // ホーム画面へ（MainPage など）
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MainPage()),
                      (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}