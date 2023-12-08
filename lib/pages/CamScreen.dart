import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:math';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late RTCVideoRenderer _localRenderer;
  late RTCPeerConnection _peerConnection;
  bool _isRendererReady = false;

  @override
  void initState() {
    super.initState();
    _localRenderer = RTCVideoRenderer();
    _initRenderers();
    _createPeerConnection().then((pc) {
      _peerConnection = pc;
      _createOffer();
    });
  }

  void _initRenderers() async {
    await _localRenderer.initialize();
    setState(() {
      _isRendererReady = true;
    });
  }

  Future<RTCPeerConnection> _createPeerConnection() async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };
    final Map<String, dynamic> constraints = {
      'mandatory': {},
      'optional': [],
    };

    RTCPeerConnection pc =
        await createPeerConnection(configuration, constraints);

    if (_isRendererReady && _localRenderer.srcObject != null) {
      pc.addStream(_localRenderer.srcObject!);
    }

    pc.onIceCandidate = (candidate) {};
    pc.onAddStream = (stream) {};

    return pc;
  }

  void _createOffer() async {
    final Map<String, dynamic> offerSDPConstraints = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': [],
    };

    RTCSessionDescription description =
        await _peerConnection.createOffer(offerSDPConstraints);
    await _peerConnection.setLocalDescription(description);
    // ส่ง SDP ของเราไปยังอีกฝั่ง (เช่นผ่าน signaling)
  }

  void _createRoom() {
    String roomID = generateRoomID();
    // ดำเนินการสร้างห้อง (เช่นส่งคำขอสร้างห้องผ่าน signaling พร้อมส่ง roomID)
    print('Created room with ID: $roomID');
    // ตัวอย่าง: เรียกฟังก์ชันที่ใช้ส่งคำขอสร้างห้องพร้อม roomID
  }

  String generateRoomID() {
    Random random = Random();
    int randomNumber = random.nextInt(10000); // สุ่มเลขในช่วง 0-9999
    return randomNumber.toString().padLeft(4, '0'); // แปลงให้เป็นสตริง 4 หลัก
  }

  void _joinRoom(String roomID) {
    if (roomID.isNotEmpty) {
      // ดำเนินการเข้าร่วมห้อง (เช่นส่งคำขอเข้าร่วมห้องผ่าน signaling พร้อมส่ง roomID)
      print('Joined room with ID: $roomID');
      // ตัวอย่าง: เรียกฟังก์ชันที่ใช้ส่งคำขอเข้าร่วมห้องพร้อม roomID
    } else {
      // แสดงข้อความแจ้งเตือนหากผู้ใช้ไม่กรอก Room ID
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter Room ID.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _peerConnection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _createRoom,
              child: Text('Create Room'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinRoomScreen(),
                  ),
                );
              },
              child: Text('Join Room'),
            ),
            SizedBox(height: 20),
            _isRendererReady && _localRenderer.srcObject != null
                ? RTCVideoView(_localRenderer)
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class JoinRoomScreen extends StatelessWidget {
  TextEditingController _roomIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Room'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _roomIdController,
              decoration: InputDecoration(
                labelText: 'Enter Room ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String roomID = _roomIdController.text;
                _CamScreenState()._joinRoom(roomID);
              },
              child: Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
