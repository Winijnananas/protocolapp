import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initRTC();
  }

  Future<void> _initRTC() async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': true,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _peerConnection = await createPeerConnection(configuration, {});

    if (_localStream != null) {
      _peerConnection?.addStream(_localStream!);
    }

    _localRenderer.srcObject = _localStream;
    await _localRenderer.initialize();
  }

  @override
  void dispose() {
    _localStream?.dispose();
    _peerConnection?.close();
    _localRenderer.dispose();
    super.dispose();
  }

  void toggleCamera() async {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks()[0];
      await videoTrack.switchCamera();
    }
  }

  void toggleMute() {
    if (_localStream != null) {
      final audioTrack = _localStream!.getAudioTracks()[0];
      audioTrack.enabled = !audioTrack.enabled;
      setState(() {}); // ให้ UI ทำการ rebuild เพื่อแสดงสถานะเปิด/ปิดเสียงใหม่
    }
  }

  void hangUp() {
    _peerConnection?.close();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CamScreen'),
      ),
      body: Center(
        child: _localRenderer.textureId != null
            ? RTCVideoView(_localRenderer)
            : CircularProgressIndicator(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: toggleCamera,
            tooltip: 'Switch Camera',
            child: Icon(Icons.switch_camera),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: toggleMute,
            tooltip: 'Toggle Mute',
            child: Icon(Icons.mic, color: _isMuted() ? Colors.red : null),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: hangUp,
            tooltip: 'Hang Up',
            child: Icon(Icons.call_end),
          ),
        ],
      ),
    );
  }

  bool _isMuted() {
    if (_localStream != null) {
      final audioTrack = _localStream!.getAudioTracks()[0];
      return !audioTrack.enabled;
    }
    return false;
  }
}
