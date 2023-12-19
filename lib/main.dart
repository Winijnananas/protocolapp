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
    HomeScreen(),
    CamScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Colors.blue, // กำหนดสีพื้นหลังของ BottomNavigationBar เป็นสีน้ำเงิน
        unselectedItemColor:
            Colors.white, // กำหนดสีของไอคอนที่ไม่ได้เลือกเป็นสีขาว
        selectedItemColor: Colors.yellow, // กำหนดสีของไอคอนที่เลือกเป็นสีขาว
        type: BottomNavigationBarType
            .fixed, // กำหนด type เป็น fixed เพื่อให้แสดงทุกรายการตลอดเวลา
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Contact Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'About',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
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
