import 'package:flutter/material.dart';
import 'screen/pet_profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timo',
      home: ProfilePage(),
    );
  }
}