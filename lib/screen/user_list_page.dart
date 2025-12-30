import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/screen/pet_list_page.dart';
import 'chat_page.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key, required this.onAvatarTap});
  final void Function(String userId) onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: const Text('Talk', style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w700, letterSpacing: 1.0),)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final users = snapshot.data!.docs.where((u) => u.id != currentUser.uid).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final data = user.data() as Map<String, dynamic>;
              return ListTile(
                title: LayoutGrid(
                  columnSizes: [50.px, 12.px, 1.fr],
                  rowSizes: [50.px],
                  children: [
                    GestureDetector(
                      child: Align(
                          child: CircleAvatar(
                            radius: 56,
                            backgroundImage: AssetImage('assets/images/header_image.jpg'),
                            backgroundColor: Colors.grey[200],
                          )
                      ),
                      onTap: () => onAvatarTap(user.id),
                    ).withGridPlacement(columnStart: 0, rowStart: 0),
                    GestureDetector(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data['username'] ?? 'no username',
                            overflow: TextOverflow.ellipsis,
                          )
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatPage(
                              partnerId: user.id,
                              partnerEmail: user['email'],
                              partnerUsername: user['username'],
                            ),
                          ),
                        );
                      },
                    ).withGridPlacement(columnStart: 2, rowStart: 0),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}