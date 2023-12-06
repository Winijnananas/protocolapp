import 'package:flutter/material.dart';
import './CamScreen.dart'; // นำเข้าหน้า CamScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CentralRTCApp',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is the Home Page',
              style: TextStyle(color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () {
                // เมื่อปุ่มถูกกด
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CamScreen()), // ไปยังหน้า CamScreen
                );
              },
              child: Text('Go to CamScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
