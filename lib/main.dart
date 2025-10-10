import 'package:flutter/material.dart';
import 'package:timo/screen/chat_list.dart';
import 'package:timo/screen/login_page.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'screen/pet_profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timo',
      home: ChatList(),
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => PetListPage()
      // }
    );
  }
}