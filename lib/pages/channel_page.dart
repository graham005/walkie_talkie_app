// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'walkie_talkie_page.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  final _channelController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Channels'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _channelController,
              decoration: InputDecoration(
                hintText: 'Enter Channel Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => WalkieTalkiePage(
                      channelName : _channelController.text
                    ))
                  );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Join Channel')
              )
          ],
        ),
        ),
    );
  }
}