import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Timo',
                style: TextStyle(
                  color: Color(0xFF2B323A),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                  fontSize: 32.0
                ),
              ),
              SizedBox(height: 32.0,),
              Container(
                width: screenWidth * 0.6,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'mail',
                  )
                ),
              ),
              SizedBox(height: 16.0,),
              Container(
                width: screenWidth * 0.6,
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                    )
                ),
              ),
              SizedBox(height: 16.0,),
              Container(
                width: screenWidth * 0.6,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  onPressed: (){},
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0,),
              Text(
                'アカウントを作成する',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
