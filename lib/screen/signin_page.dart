import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'main_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ログインしました！')),
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainPage()),
      );

      // ここで自動的にauthStateChanges()が検知されてMainPageへ遷移します
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'このメールアドレスは登録されていません。';
          break;
        case 'wrong-password':
          message = 'パスワードが間違っています。';
          break;
        case 'invalid-email':
          message = 'メールアドレスの形式が正しくありません。';
          break;
        default:
          message = 'ログインに失敗しました: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'ログイン',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3c434c),
            fontSize: 18
        ),
      )),
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
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF27CA84)),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'パスワード',
                    icon: Icon(Icons.key, color: Colors.green,),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signIn,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84)),
                  minimumSize: WidgetStatePropertyAll(Size(200, 50))
                ),
                child: const Text(
                  'ログイン',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.6
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpPage()),
                  );
                },
                child: const Text(
                  '新規登録はこちら',
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