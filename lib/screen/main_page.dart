import 'package:flutter/material.dart';
import 'package:timo/constants.dart';
import 'package:timo/screen/chat_page.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'package:timo/screen/pet_profile_page.dart';
import 'package:timo/screen/user_list_page.dart';

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    //BottomNavigationItemの各々のIconをタップすると遷移するページ。アイコンの並び順。
    PetListPage(),
    PetListPage(),
    PetListPage(),
    PetListPage(),
    UserListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'message'),
        ],
        selectedItemColor: greyDark, //selectされているIcon・labelのcolor
        selectedIconTheme: IconThemeData(color:  Color(0xFF5AA3C6)), //selectされているIconのcolor
      ),
    );


  }
}