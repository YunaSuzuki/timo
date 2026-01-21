import 'package:flutter/gestures.dart';
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
          .showSnackBar(SnackBar(content: Text('このメールアドレスはご使用できません。')));
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
              fontWeight: FontWeight.w700,
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
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    floatingLabelStyle: TextStyle(fontSize: 20, color: Color(0xFF27CA84), fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFb7b7b7)),
                    ),
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
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF27CA84)),
                  minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))
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
                    TextSpan(text: 'すでにアカウントをお持ちの方は'),
                    TextSpan(
                      text: 'こちら',
                      style: TextStyle(
                        color: Color(0xFF27CA84),
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignInPage()),
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