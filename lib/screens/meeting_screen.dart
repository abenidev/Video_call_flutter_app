import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_chat_app/components/home_meeting_button.dart';
import 'package:video_chat_app/resources/jitsi_meet_method.dart';
import 'package:video_chat_app/screens/video_call_screen.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  void createMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(100000000) + 10000000).toString();
    _jitsiMeetMethods.createNewMeeting(
      roomName: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  void joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, VideoCallScreen.routeName);
  }

  @override
  void dispose() {
    JitsiMeet().hangUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () {
                createMeeting();
              },
              icon: Icons.videocam,
              label: 'New Meeting',
            ),
            HomeMeetingButton(
              onPressed: () {
                joinMeeting(context);
              },
              icon: Icons.add_box_rounded,
              label: 'Join Meeting',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              label: 'Schedule',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.arrow_upward,
              label: 'Share Screen',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just a tap!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        //
      ],
    );
  }
}
