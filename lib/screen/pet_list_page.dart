import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PetListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timo',
          style: TextStyle(
              color: Color(0xFF2B323A),
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0
          ),
        ),
      ),
      body: Column(
        children: <Widget>[

          Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10), // inner padding
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
          ),
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
    );
  }
}
