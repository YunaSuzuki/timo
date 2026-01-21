import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timo/constants.dart';
import 'package:timo/screen/blanc_page.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'package:timo/screen/user_list_page.dart';
import 'package:timo/screen/userHomeProfile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String? _targetUserId; // ← 表示中のユーザーID
  late final String currentUserId;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    currentUserId = user!.uid;

    // 初期表示は「ログイン中ユーザーの PetList」
    _targetUserId = currentUserId;
  }

  void _openProfile(String userId) {
    setState(() {
      _targetUserId = userId;
      _selectedIndex = 0; // Homeタブに切り替え
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      UserHomeProfile(key:ValueKey(_targetUserId), userId: _targetUserId!),
      BlancPage(),
      BlancPage(),
      BlancPage(),
      UserListPage(onAvatarTap: _openProfile), // ← コールバックで切替
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: greyDark,
        unselectedItemColor: greyDark,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
            if (i == 0) {
              _targetUserId = currentUserId;
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'message'),
        ],
      ),
    );
  }
}