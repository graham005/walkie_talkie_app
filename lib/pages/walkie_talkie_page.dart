// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class WalkieTalkiePage extends StatefulWidget {
  final String appId = "9733f2ae2b3e48b282a30bd2f54774e6";
  final String channelName;
  const WalkieTalkiePage({required this.channelName, super.key});

  @override
  State<WalkieTalkiePage> createState() => _WalkieTalkiePageState();
}

class _WalkieTalkiePageState extends State<WalkieTalkiePage> {
  late RtcEngine _engine;
  bool _muted = false;

  @override
  void initState(){
    super.initState();
    initializeAgora();
  }
  Future<void> initializeAgora() async {
    // create an instance of the Agora engine 
    _engine = createAgoraRtcEngine();

    // Initialize Agora engine
    await _engine.initialize(RtcEngineContext(
      appId: widget.appId,
    ));
    // Enable audio
    await _engine.enableAudio();

    // Register event handler
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, uid) {
          print('Successfully joined channel: ${connection.channelId}, with uid: $uid');
        },
        onLeaveChannel: (connection, stats) {
          print('Left channel: ${connection.channelId}');
        }
      ),
    );

    // Join the agora channel
    await _engine.joinChannel(
      token: '',
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose(){
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel: ${widget.channelName}'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: _toggleMute, 
            icon: Icon(
              _muted ? Icons.mic_off : Icons.mic,
              size: 50,
              color: Colors.green[800],
            )
            ),
            SizedBox(height: 20),
            Text(
              _muted ? 'Microphone Muted' : 'Miceophone Active',
              style: TextStyle(fontSize: 24, color: Colors.green[800]),
            )
          ],
        ),
      ),
    );
  }
  void _toggleMute(){
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }
}