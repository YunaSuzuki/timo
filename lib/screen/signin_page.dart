import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'main_page.dart';
import 'package:flutter/gestures.dart';


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
                    labelText: 'Email',
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontFamily: 'Quicksand', fontWeight: FontWeight.w700),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'sample@email.com',
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C), fontFamily: 'Quicksand'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
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
                    labelText: 'Password',
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontFamily: 'Quicksand', fontWeight: FontWeight.w700),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C), fontFamily: 'Quicksand'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signIn,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84)),
                  minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))
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
              SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF545454),
                  ),
                  children: [
                    TextSpan(text: '新規登録は'),
                    TextSpan(
                        text: 'コチラ',
                        style: TextStyle(
                          color: Color(0xFF27CA84),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignUpPage()),
                            );
                          }
                    )
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}