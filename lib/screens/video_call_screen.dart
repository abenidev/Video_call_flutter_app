import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_chat_app/components/meeting_option.dart';
import 'package:video_chat_app/constants/colors.dart';
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

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
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
        backgroundColor: backgroundColor,
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
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
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
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Join', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            onChanged: onAudioMuted,
            isMute: isAudioMuted,
            label: 'Mute Audio',
          ),
          MeetingOption(
            onChanged: onVideoMuted,
            isMute: isVideoMuted,
            label: 'Turn Off My Video',
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
