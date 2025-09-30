import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'constants.dart';

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
            //ProfileImage
            Center(
              child: Text('Timo', style: profileTextStyle,),
            ), //pet's name
            Center(
              child: Text('@username', style: profileTextStyle,),
            ),
            SizedBox(height: 40.0,),
            SizedBox(
              height: 250,
              child: LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
                children: <Widget>[
                  Container(
                    child: Text('お誕生日', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 0),
                  Container(
                    child: Text('2021/06/24', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 0),
                  Container(
                    child: Text('犬種', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 1),
                  Container(
                    child: Text('柴犬', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 1),
                  Container(
                    child: Text('好きなこと', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 2),
                  Container(
                    child: Text('家族・おやつ', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 2),
                  Container(
                    child: Text('嫌いなこと', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 3),
                  Container(
                    child: Text('お風呂', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 3),
                  Container(
                    child: Text('去勢・避妊', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 4),
                  Container(
                    child: Text('済', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 4),
                  Container(
                    child: Text('飼い主さんから', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 0, rowStart: 5, columnSpan: 2),
                  Container(
                    child: Text('サンプルテキストサンプルテキストサンプルテキストサンプルテキストサンプルテキストサンプルテキスト', style: profileTextStyle,),
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