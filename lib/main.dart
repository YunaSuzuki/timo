import 'package:flutter/material.dart';
import 'package:timo/authgate.dart';
import 'package:timo/screen/chat_list.dart';
import 'package:timo/screen/login_page.dart';
import 'package:timo/screen/main_page.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'screen/pet_profile_page.dart';
import 'screen/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timo',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => AuthGate(),
        'chat_list': (BuildContext context) => ChatList(),
        'pet_profile_page' : (BuildContext context) => ProfilePage(),
        'chat': (BuildContext context) => Chat(),
      }
    );
  }
}