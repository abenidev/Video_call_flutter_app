import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_chat_app/resources/auth_methods.dart';
import 'package:video_chat_app/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createNewMeeting({required String roomName, required bool isAudioMuted, required bool isVideoMuted, String username = ''}) async {
    String name;
    if (username.isEmpty) {
      name = _authMethods.user.displayName!;
    } else {
      name = username;
    }
    try {
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": "Room Id: $roomName",
        },
        featureFlags: {"unsaferoomwarning.enabled": false},
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      _firestoreMethods.addToMeetingHistory(roomName);
      jitsiMeet.join(options);
    } catch (e) {
      debugPrint('e: ${e}');
    }

    // JitsiMeetEventListener listener = JitsiMeetEventListener(
    JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: $url");
      },
      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
          "participantId: $participantId",
        );
        // participants.add(participantId!);
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        debugPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
          "isPrivate: $isPrivate",
        );
      },
      readyToClose: () {
        debugPrint("readyToClose");
      },
    );
  }
}
