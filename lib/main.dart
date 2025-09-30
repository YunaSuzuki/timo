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
        padding: EdgeInsets.only(left: 30.0),
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
            Table(
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    TableCell(child: Text('お誕生日', style: profileTextStyle,)),
                    TableCell(child: Text('2021/06/24', style: profileTextStyle,)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(child: Text('犬種', style: profileTextStyle,)),
                    TableCell(child: Text('柴犬', style: profileTextStyle,)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(child: Text('好きなこと', style: profileTextStyle,)),
                    TableCell(child: Text('おやつ・家族', style: profileTextStyle,)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(child: Text('嫌いなこと', style: profileTextStyle,)),
                    TableCell(child: Text('お風呂', style: profileTextStyle,)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Text('去勢・避妊', style: profileTextStyle,)
                    ),
                    TableCell(child: Text('済', style: profileTextStyle,)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                        child: Text('飼い主さんからコメント', style: profileTextStyle,)
                    ),
                    TableCell(
                        child: Text('')
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}