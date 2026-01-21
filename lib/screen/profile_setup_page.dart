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

        // accountID を確保
        transaction.set(accountIdRef, {
          'uid': widget.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // users にプロフィール保存
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("プロフィール作成", style: TextStyle( fontWeight: FontWeight.bold),)),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "アカウント名",
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontWeight: FontWeight.bold),
                    hintText: '柴犬ティモファミリー',
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                TextField(
                  controller: _accountIdController,
                  decoration: const InputDecoration(
                    labelText: "アカウントID",
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontWeight: FontWeight.bold),
                    hintText: '@shiba_timo',
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)
                    ),
                  ),
                ),
                ),
                SizedBox(height: 30,),
                TextField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    labelText: "自己紹介",
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontWeight: FontWeight.bold),
                    hintText: '柴犬を2匹飼っています！',
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isSaving ? null : _saveProfile,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84)),
                    minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      )
                    )
                  ),
                  child: isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("保存", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}