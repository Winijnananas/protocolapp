import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isMuted = false;

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

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
    // Perform actions for muting/unmuting
  }

  void hangUp() {
    // Perform hang-up action
    Navigator.pop(context); // Example: Return to the previous screen
  }

  void toggleCamera() {
    // Perform actions for toggling the camera
    // Example: switch between front and back cameras
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'RTC SCREEN',
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
          'RTC SCREEN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(controller),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              children: [
                IconButton(
                  onPressed: toggleMute,
                  icon: Icon(
                    isMuted ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: hangUp,
                  icon: Icon(
                    Icons.call_end,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: toggleCamera,
                  icon: Icon(
                    Icons.switch_camera,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
