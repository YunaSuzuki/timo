import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import '/constants.dart';

class ProfilePage extends StatelessWidget {
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
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: ClipOval(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment(0, -0.8), // ← y方向を上に寄せる (-1=上, 0=中央, 1=下)
                    child: Image.asset('assets/images/pet_profile_image.JPG'),
                  ),
                ),
              ),
            ),
            //ProfileImage
            Center(
              child: Text('Timo', style: appTextStyle(fontSize: 18.0),),
            ), //pet's name
            Center(
              child: Text('@username', style: appTextStyleEn(fontSize: 12.0, fontWeight: FontWeight.w400),),
            ),
            SizedBox(height: 40.0,),
            SizedBox(
              height: 250,
              child: LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
                children: <Widget>[
                  Container(
                    child: Text('お誕生日', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 0),
                  Container(
                    child: Text('2021/06/24', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 1, rowStart: 0),
                  Container(
                    child: Text('犬種', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 1),
                  Container(
                    child: Text('柴犬', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 1, rowStart: 1),
                  Container(
                    child: Text('好きなこと', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 2),
                  Container(
                    child: Text('家族・おやつ', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 1, rowStart: 2),
                  Container(
                    child: Text('嫌いなこと', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 3),
                  Container(
                    child: Text('お風呂', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 1, rowStart: 3),
                  Container(
                    child: Text('去勢・避妊', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 4),
                  Container(
                    child: Text('済', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 1, rowStart: 4),
                  Container(
                    child: Text('飼い主さんから', style: appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 5, columnSpan: 2),
                  Container(
                    child: Text('サンプルテキストサンプルテキストサンプルテキストサンプルテキストサンプルテキストサンプルテキスト', style:  appTextStyle(),),
                  ).withGridPlacement(columnStart: 0, rowStart: 6, columnSpan: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}