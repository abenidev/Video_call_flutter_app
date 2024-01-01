import 'package:flutter/material.dart';
import 'package:video_chat_app/constants/colors.dart';

class MeetingOption extends StatelessWidget {
  const MeetingOption({super.key, required this.label, required this.isMute, required this.onChanged});
  final String label;
  final bool isMute;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Switch.adaptive(value: isMute, onChanged: onChanged)
        ],
      ),
    );
  }
}
