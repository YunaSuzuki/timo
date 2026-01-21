import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen/signup_page.dart';
import 'screen/main_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ローディング中
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ログイン済み（サインアップ完了含む）
        if (snapshot.hasData) {
          return MainPage();
        }

        // 未ログイン
        return const SignUpPage();
      },
    );
  }
}