import 'package:flutter/material.dart';
import 'package:timo/authgate.dart';
import 'package:timo/screen/signin_page.dart';
import 'package:timo/screen/main_page.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'package:timo/screen/user_list_page.dart';
import 'screen/pet_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timo',
      theme: ThemeData(
        fontFamily: 'M_Plus_Rounded_1c'
      ),
      home: const AuthGate(),
      routes: <String, WidgetBuilder>{
        'chat_list': (BuildContext context) => ProfilePage(),
        'pet_profile_page' : (BuildContext context) => ProfilePage(),
        'chat': (BuildContext context) => ProfilePage(),
      }
    );
  }
}