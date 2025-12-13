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
    final username = _usernameController.text.trim();
    final accountID = _accountIdController.text.trim();
    final bio = _bioController.text.trim();

    if (username.isEmpty || accountID.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ユーザーネームとアカウントIDは必須です')),
      );
      return;
    }

    setState(() => isSaving = true);

    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.runTransaction((transaction) async {
        final accountIdRef =
        firestore.collection('account_ids').doc(accountID);

        final accountIdSnap = await transaction.get(accountIdRef);

        // 🔒 accountID が既に存在していたら失敗
        if (accountIdSnap.exists) {
          throw Exception('ACCOUNT_ID_TAKEN');
        }

        // 🔥 accountID を確保
        transaction.set(accountIdRef, {
          'uid': widget.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // 🔥 users にプロフィール保存
        transaction.set(
          firestore.collection('users').doc(widget.uid),
          {
            'email': widget.email,
            'username': username,
            'accountID': accountID,
            'bio': bio,
            'createdAt': FieldValue.serverTimestamp(),
          },
        );
      });

      // 成功 → ホーム画面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainPage()),
      );

    } catch (e) {
      if (e.toString().contains('ACCOUNT_ID_TAKEN')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('このアカウントIDは既に使われています')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存に失敗しました: $e')),
        );
      }
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Setup")),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("保存"),
            ),
          ],
        ),
      ),
    );
  }
}