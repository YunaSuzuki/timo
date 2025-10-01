import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetListPage extends StatelessWidget {

  final double headerHeight = 220;
  final double profileRadius = 56;
  final String headerAsset = 'assets/images/header_image.jpg';
  final String profileAsset = 'assets/images/~';


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
                          child: Text('ティモの柴旅日記', style: profileTextStyle,),
                        ).withGridPlacement(columnStart: 1, rowStart: 0),
                        Container(
                          child: Text('@username', style: sTextStyle,),
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
                    child: Text("Follow", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0),),
                  ),
                  SizedBox(width: 8.0,),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10), // inner padding
                    ),
                    child: Text("Friends", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.0),),
                  ),
                  SizedBox(width: 12.0,),
                  Icon(FontAwesomeIcons.envelope, size: 30.0, color: Colors.grey[700],),
                ],
              ),
            ), //TextButton
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
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
                          child: Text('Timo', style: profileTextStyle,),
                        ).withGridPlacement(columnStart: 1, rowStart: 0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('柴犬', style: profileTextStyle,),
                              Text('/', style: profileTextStyle,),
                              Text('4歳', style: profileTextStyle,)
                            ],
                          ),
                        ).withGridPlacement(columnStart: 1, rowStart: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  SizedBox(
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
                          child: Text('Timo', style: profileTextStyle,),
                        ).withGridPlacement(columnStart: 1, rowStart: 0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('柴犬', style: profileTextStyle,),
                              Text('/', style: profileTextStyle,),
                              Text('4歳', style: profileTextStyle,)
                            ],
                          ),
                        ).withGridPlacement(columnStart: 1, rowStart: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  SizedBox(
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
                          child: Text('Timo', style: profileTextStyle,),
                        ).withGridPlacement(columnStart: 1, rowStart: 0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('柴犬', style: profileTextStyle,),
                              Text('/', style: profileTextStyle,),
                              Text('4歳', style: profileTextStyle,)
                            ],
                          ),
                        ).withGridPlacement(columnStart: 1, rowStart: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
