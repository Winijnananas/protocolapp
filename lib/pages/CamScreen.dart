import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  MediaStream? _localStream;
  final _localRenderer = RTCVideoRenderer();
  final _auth = FirebaseAuth.instance;
  late DatabaseReference _messagesRef;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _getUserMedia();
    _messagesRef = FirebaseDatabase.instance.reference().child('messages');
  }

  void initRenderers() async {
    await _localRenderer.initialize();
  }

  void _getUserMedia() async {
    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': true,
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);

    setState(() {
      _localStream = stream;
      _localRenderer.srcObject = _localStream;
    });
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }

  Future<void> _createRoom() async {
    if (_auth.currentUser != null) {
      String roomId = DateTime.now().millisecondsSinceEpoch.toString();

      await _messagesRef.child(roomId).child(_auth.currentUser!.uid).set({
        'displayName': _auth.currentUser!.displayName,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RoomScreen(roomId: roomId)),
      );
    } else {
      // Handle case when _auth.currentUser is null
    }
  }

  Future<void> _joinRoom(String roomId) async {
    if (_auth.currentUser != null) {
      await _messagesRef.child(roomId).child(_auth.currentUser!.uid).set({
        'displayName': _auth.currentUser!.displayName,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RoomScreen(roomId: roomId)),
      );
    } else {
      // Handle case when _auth.currentUser is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cam Screen'),
      ),
      body: Container(
        child: _localStream != null
            ? RTCVideoView(_localRenderer)
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _createRoom,
            tooltip: 'Create Room',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              String roomId = ''; // Replace with the room ID to join
              await _joinRoom(roomId);
            },
            tooltip: 'Join Room',
            child: Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }
}

class RoomScreen extends StatelessWidget {
  final String roomId;

  const RoomScreen({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: $roomId'),
      ),
      body: Center(
        child: Text('You are in Room: $roomId'),
      ),
    );
  }
}
