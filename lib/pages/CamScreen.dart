import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:firebase_database/firebase_database.dart';

class CamScreen extends StatefulWidget {
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  final reference = FirebaseDatabase.instance.reference().child('vdo_calls');

  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  late MediaStream _remoteStream;

  @override
  void initState() {
    super.initState();
    initWebRTC();
  }

  Future<void> initWebRTC() async {
    final configuration = <String, dynamic>{'iceServers': []};
    _peerConnection = await createPeerConnection(configuration, {});

    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': true,
    };
    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    _localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, _localStream);
    });

    _peerConnection.onIceCandidate = (candidate) {
      reference.child('candidates').push().set({
        'from': 'user_A',
        'candidate': candidate.toMap(),
      });
    };

    reference.child('call_request').onValue.listen((event) {
      if (event.snapshot.value != null) {
        startVDOCall();
      } else {
        // Handle case where no VDO call request is found
      }
    });
  }

  void startVDOCall() async {
    final offer = await _peerConnection.createOffer({});
    await _peerConnection.setLocalDescription(offer);

    reference.child('call_response').set({'from': 'user_B'});

    _peerConnection.onIceCandidate = (candidate) {
      reference.child('candidates').push().set({
        'from': 'user_B',
        'candidate': candidate.toMap(),
      });
    };

    reference.child('offers').push().set({
      'from': 'user_B',
      'offer': {
        'type': offer.type,
        'sdp': offer.sdp,
      },
    });
  }

  @override
  void dispose() {
    _localStream.dispose();
    _remoteStream.dispose();
    _peerConnection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VDO Call')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            initiateCall();
          },
          child: Text('Start VDO Call'),
        ),
      ),
    );
  }

  void initiateCall() {
    reference.child('call_request').set({'from': 'user_A', 'to': 'user_B'});
  }
}
