import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:timo/constants.dart';
import 'package:timo/screen/main_page.dart';

class ChatList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Talk',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return LayoutGrid(
                columnSizes: [80.px, 1.fr, 50.px],
                rowSizes: [40.px, 50.px],
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
                    child: Text('sample-chat-text', style: profileTextStyle,),
                  ).withGridPlacement(columnStart: 1, rowStart: 1, columnSpan: 2),
                  Container(
                    child: Text('06.24', style: TextStyle(color: Colors.grey[700], fontSize: 12.0),),
                  ).withGridPlacement(columnStart: 2, rowStart: 0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
