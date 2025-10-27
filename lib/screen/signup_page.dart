import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timo/screen/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;

      if (user != null) {
        // Firestoreにユーザー情報を保存
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登録が完了しました！')),
      );

    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'パスワードが弱すぎます。';
      } else if (e.code == 'email-already-in-use') {
        message = 'このメールはすでに使用されています。';
      } else if (e.code == 'invalid-email') {
        message = 'メールアドレスが正しくありません。';
      } else {
        message = '登録に失敗しました: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'アカウント作成',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3c434c),
              fontSize: 18
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'メールアドレス',
                    icon: Icon(Icons.mail, color: Colors.green,),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    icon: Icon(Icons.key, color: Colors.green,),
                    labelText: 'パスワード',
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                child: const Text(
                  'アカウント作成',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.6
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84))
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                  );
                },
                child: const Text(
                  'すでにアカウントをお持ちの方はこちら',
                  style: TextStyle(
                    color: Color(0xFF2B323A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}