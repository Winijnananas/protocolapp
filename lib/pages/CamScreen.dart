// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';

// class CamScreen extends StatefulWidget {
//   @override
//   _CamScreenState createState() => _CamScreenState();
// }

// class _CamScreenState extends State<CamScreen> {
//   late RTCVideoRenderer _localRenderer;
//   late RTCPeerConnection _peerConnection;

//   @override
//   void initState() {
//     super.initState();
//     _localRenderer = RTCVideoRenderer();
//     _initWebRTC();
//   }

//   Future<void> _initWebRTC() async {
//     _peerConnection = await createPeerConnection({
//       'iceServers': [
//         {'url': 'stun:stun.l.google.com:19302'},
//       ],
//     }, {});

//     _localRenderer = RTCVideoRenderer(); // Initialize _localRenderer
//     await _localRenderer.initialize();

//     //  getUserMedia and other WebRTC setup

//     Future<void> _initWebRTC() async {
//       _peerConnection = await createPeerConnection({
//         'iceServers': [
//           {'url': 'stun:stun.l.google.com:19302'},
//         ],
//       }, {});

//       _localRenderer = RTCVideoRenderer(); // Initialize _localRenderer
//       await _localRenderer.initialize();

//       MediaStream stream = await navigator.mediaDevices.getUserMedia({
//         'audio': true,
//         'video': true,
//       });
//       stream.getTracks().forEach((track) {
//         _peerConnection.addTrack(track, stream);
//       });

//       _localRenderer.srcObject = stream;

//       RTCSessionDescription offer = await _peerConnection.createOffer({});
//       await _peerConnection.setLocalDescription(offer);

//       // Send offer to signaling server
//       // You'll need to implement this part to send the offer to your signaling server
//     }
//   }

//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     _peerConnection.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CamScreen'),
//       ),
//       body: Center(
//         child: _localRenderer.srcObject != null
//             ? RTCVideoView(_localRenderer)
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement logic to toggle mute/unmute here
//         },
//         child: Icon(Icons.mic),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './About.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลกล้องแรกที่พบ
    _controller = CameraController(
      // สามารถเปลี่ยนข้อมูลกล้องตามที่คุณมีได้
      CameraDescription(
        name: 'Camera 0',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 90, // สามารถเปลี่ยนค่าตามต้องการของกล้อง
      ),

      ResolutionPreset.medium,
    );

    // เริ่มต้นกล้องและเก็บ Future ไว้
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // ห้ามลืม dispose controller เพื่อป้องกันการใช้งานทรัพยากรที่ไม่จำเป็น
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กล้อง'),
      ),
      // ใช้ FutureBuilder เพื่อให้ UI รอการเริ่มต้นของกล้อง
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // ถ้าการเริ่มต้นเสร็จสิ้น ให้แสดงกล้อง
            return CameraPreview(_controller);
          } else {
            // ถ้ายังไม่เสร็จ ให้แสดง Indicator หรือ Loader
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // เพิ่มโค้ดสำหรับการกดปุ่มวางสายที่นี่
          // เช่น เรียกฟังก์ชันสำหรับการบันทึกภาพหรือวิดีโอที่ถ่ายจากกล้อง
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
