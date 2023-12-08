// import 'package:flutter/material.dart';
// import 'package:protocolapp/app.dart';

// void main() {
//   runApp(MyApp());
// }

import 'package:flutter/material.dart';
import './pages/HomeScreen.dart';
import './pages/CamScreen.dart';
import './navigations/routes.dart';
import './pages/About.dart';
import 'package:firebase_core/firebase_core.dart'; // import Firebase Core
// import './pages/CamScreen.dart'; // นำเข้า CamScreen ไว้ที่นี่

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // เรียกใช้ Firebase.initializeApp() ที่นี่
  runApp(MyApp());
}
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RTC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomTabNavigator(), // กำหนดให้ BottomTabNavigator เป็นหน้าแรก
    );
  }
}

class BottomTabNavigator extends StatefulWidget {
  @override
  _BottomTabNavigatorState createState() => _BottomTabNavigatorState();
}

class _BottomTabNavigatorState extends State<BottomTabNavigator> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeScreen(), // หน้า HomeScreen
    CamScreen(), // หน้า CamScreen
    AboutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex], // แสดงหน้าจอที่เลือกจาก _currentIndex
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .contact_phone), // ใช้ Icon contact_phone จาก Material Icons
            label: 'Contact Staff', // แก้ไขข้อความ label ตามที่ต้องการ
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help), // ใช้ Icon contact_phone จาก Material Icons
            label: 'About', // แก้ไขข้อความ label ตามที่ต้องการ
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // เปลี่ยนหน้าจอตาม index ที่เลือก
          });
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         home: HomeScreen(),
//       );
// }
