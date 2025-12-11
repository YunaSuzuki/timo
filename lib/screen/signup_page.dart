import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timo/screen/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_setup_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _signUp() async {
    try {
      setState(() => isLoading = true);

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 登録成功 → プロフィール設定ページへ
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSetupPage(
            uid: userCredential.user!.uid,
            email: _emailController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('エラー: $e')));
    } finally {
      setState(() => isLoading = false);
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
                  controller: _emailController,
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
                  controller: _passwordController,
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
                onPressed: _signUp,
                child: const Text(
                  'アカウント作成',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.6
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84)),
                    minimumSize: WidgetStatePropertyAll(Size(200, 50))
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