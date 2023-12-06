import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        controller = CameraController(cameras[0], ResolutionPreset.high);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (controller == null || !controller.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Camera Page',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CameraPreview(controller), // แสดงกล้องใน Widget CameraPreview
            SizedBox(height: 20),
            Text(
              'This is the Camera Page',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
