import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/constants.dart';
import 'package:timo/screen/pet_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetListPage extends StatefulWidget {
  final String? userId;

  const PetListPage({super.key, required this.userId});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {

  final double tabBarViewHeight = 350;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserProfile(widget.userId);
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
    return ListView.separated(
      padding: EdgeInsets.only(left: 28.0, right: 12.0, top: 16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage())
            );
          },
          child: Container(
            height: 80,
            child: LayoutGrid(
              columnSizes: [auto, 1.fr],
              rowSizes: [1.fr, 1.fr],
              columnGap: 16,
              children: <Widget>[
                Container(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        alignment: Alignment(0, -0.8), // ← y方向を上に寄せる (-1=上, 0=中央, 1=下)
                        child: Image.asset('assets/images/pet_profile_image.JPG'),
                      ),
                    ),
                  ),
                ).withGridPlacement(columnStart: 0, rowStart: 0, rowSpan: 2),
                Container(
                  child: Row(
                    children: [
                      Text('Timo', style: appTextStyle(color: greyDark)),
                      Icon(Icons.female, color: Colors.red[400],),
                    ],
                  ),
                ).withGridPlacement(columnStart: 1, rowStart: 0),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text('柴犬', style: appTextStyle(color: greyDark)),
                      Text('/', style: appTextStyle(color: greyDark)),
                      Text('4歳', style: appTextStyle(color: greyDark),)
                    ],
                  ),
                ).withGridPlacement(columnStart: 1, rowStart: 1),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.0,),
    );
  }
}