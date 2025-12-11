import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_page.dart';

class ProfileSetupPage extends StatefulWidget {
  final String uid;
  final String email;

  const ProfileSetupPage({
    Key? key,
    required this.uid,
    required this.email,
  }) : super(key: key);

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _usernameController = TextEditingController();
  final _accountIdController = TextEditingController();
  final _bioController = TextEditingController();

  bool isSaving = false;

  Future<void> _saveProfile() async {
    try {
      setState(() => isSaving = true);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .set({
        'email': widget.email,
        'username': _usernameController.text.trim(),
        'accountID': _accountIdController.text.trim(),
        'bio': _bioController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      // 完了後ホーム画面へ（仮）
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('保存エラー: $e')));
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Setup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "ユーザーネーム"),
            ),
            TextField(
              controller: _accountIdController,
              decoration: const InputDecoration(labelText: "アカウントID"),
            ),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "自己紹介"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSaving ? null : _saveProfile,
              child: isSaving
                  ? CircularProgressIndicator(color: Colors.white)
                  : const Text("保存"),
            )
          ],
        ),
      ),
    );
  }
}