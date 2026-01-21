import 'package:flutter/material.dart';
import 'package:timo/constants.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTabs extends StatefulWidget {
  final String? userId;
  const HomeTabs({super.key, required this.userId});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {

  static const List<Tab> homeTabs = <Tab>[
    Tab(icon: Icon(Icons.pets), ),
    Tab(icon: Icon(Icons.grid_on)),
    Tab(icon: Icon(Icons.calendar_month)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    super.initState();
    fetchCurrentUserProfile(widget.userId);
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ここでauthStateChanges()が自動的に検知され、AuthGateでログイン画面に戻る
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ログアウトしました')),
    );
  }

  Future<void> fetchCurrentUserProfile(userId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (!doc.exists) return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: homeTabs.length,
      child:  Expanded(
        child: Column(
          children: [
            TabBar(tabs: homeTabs, labelColor: greyDark, indicatorColor: Colors.transparent,),
            Expanded(
                child: TabBarView(
                    children: [
                      //PetList
                      PetListPage(userId: widget.userId),
                      Center(child: Text('image post view'),),
                      Center(child: Text('Event list'),),
                      Center(
                          child: TextButton(
                              onPressed: () => _signOut(context),
                              child: Text('Sign out Button', style: TextStyle(color: Colors.black,))
                          )
                      ),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
