// import 'package:flutter/material.dart';
// import 'package:protocolapp/app.dart';

// void main() {
//   runApp(MyApp());
// }

import 'package:flutter/material.dart';
import './pages/HomeScreen.dart';
// import './pages/CamScreen.dart'; // นำเข้า CamScreen ไว้ที่นี่

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: HomeScreen(),
      );
}
