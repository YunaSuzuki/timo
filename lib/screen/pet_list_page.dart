import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timo/screen/main_page.dart';
import 'package:timo/screen/pet_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetListPage extends StatelessWidget {

  final double headerHeight = 220;
  final double profileRadius = 56;
  final String headerAsset = 'assets/images/header_image.jpg';
  final String profileAsset = 'assets/images/header_image.jpg';
  final double tabBarViewHeight = 350;

  static const List<Tab> homeTabs = <Tab>[
    Tab(icon: Icon(Icons.pets)),
    Tab(icon: Icon(Icons.grid_on)),
    Tab(icon: Icon(Icons.calendar_month)),
    Tab(icon: Icon(Icons.settings)),
  ];

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ここでauthStateChanges()が自動的に検知され、AuthGateでログイン画面に戻る
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ログアウトしました')),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                // ヘッダー部分
                Container(
                  height: headerHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // アセット画像を使う場合:
                      image: AssetImage(headerAsset),
                      // ネット画像を使う場合（コメントアウトを入れ替えて使う）:
                      // image: NetworkImage(headerUrl) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ヘッダー上にグラデーションやダークオーバーレイを置きたいとき:
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.25),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // プロフィール画像をヘッダーの下端に少し重ねて配置
                Positioned(
                  left: 16,
                  bottom: -profileRadius, // ヘッダー下に半分出すため -radius
                  child: Container(
                    padding: const EdgeInsets.all(4), // 外側の枠(ボーダー)幅
                    decoration: BoxDecoration(
                      color: Colors.white, // 枠の色（白い縁）
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: profileRadius,
                      // アセットの場合:
                      backgroundImage: AssetImage(profileAsset),
                      // ネット画像を使う場合:
                      // backgroundImage: NetworkImage(profileUrl),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0,), //header and profile image
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: LayoutGrid(
                      columnSizes: [180.px, 1.fr],
                      rowSizes: [1.fr, 1.fr],
                      children: <Widget>[
                        Container().withGridPlacement(columnStart: 0, rowStart: 0, rowSpan: 2),
                        Container(
                          child: Text('ティモの柴旅日記', style: appTextStyle(color: greyDark),),
                        ).withGridPlacement(columnStart: 1, rowStart: 0),
                        Container(
                          child: Text('@username', style: appTextStyleEn(color: greyDark, fontSize: 12.0, fontWeight: FontWeight.w400)),
                        ).withGridPlacement(columnStart: 1, rowStart: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.0,),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10), // inner padding
                    ),
                    child: Text("Follow", style: appTextStyleEn(color: Colors.white),),
                  ),
                  SizedBox(width: 8.0,),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10), // inner padding
                    ),
                    child: Text("Friends", style: appTextStyleEn(color: Colors.white),),
                  ),
                  SizedBox(width: 12.0,),
                  Icon(FontAwesomeIcons.envelope, size: 30.0, color: Colors.grey[700],),
                ],
              ),
            ), // FollowButton //TextButton
            SizedBox(height: 30.0,),
            DefaultTabController(
                length: homeTabs.length,
                child:  Expanded(
                  child: Column(
                    children: [
                      TabBar(tabs: homeTabs),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.separated(
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
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
