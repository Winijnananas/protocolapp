import 'package:flutter/material.dart';
import '../pages/HomeScreen.dart'; // นำเข้าหน้า HomeScreen
import '../pages/CamScreen.dart'; // นำเข้าหน้า CamScreen
import '../pages/About.dart';

class Routes {
  static const String home = '/';
  static const String camScreen = '/camScreen';
  static const String about = '/aboutScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case camScreen:
        return MaterialPageRoute(builder: (_) => CamScreen());
      case about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
