import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_chat_app/components/meeting_option.dart';
import 'package:video_chat_app/resources/auth_methods.dart';
import 'package:video_chat_app/resources/jitsi_meet_method.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});
  static String routeName = '/video-call-screen';

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  FocusNode roomIdFocusNode = FocusNode();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    roomIdFocusNode.requestFocus();
  }

  @override
  void dispose() {
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet().hangUp();
    super.dispose();
  }

  void _joinMeeting() {
    _jitsiMeetMethods.createNewMeeting(
      roomName: meetingIdController.text.trim(),
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              focusNode: roomIdFocusNode,
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                // fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                // fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            onChanged: onAudioMuted,
            isMute: isAudioMuted,
            label: 'Audio',
          ),
          MeetingOption(
            onChanged: onVideoMuted,
            isMute: isVideoMuted,
            label: 'Video',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: _joinMeeting,
              child: const Text('Join', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool value) {
    setState(() => isAudioMuted = value);
  }

  onVideoMuted(bool value) {
    setState(() => isVideoMuted = value);
  }
}
