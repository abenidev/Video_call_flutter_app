import 'package:flutter/material.dart';

class MeetingOption extends StatelessWidget {
  const MeetingOption({super.key, required this.label, required this.isMute, required this.onChanged});
  final String label;
  final bool isMute;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      height: 60,
      // color: secondaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            Switch.adaptive(value: isMute, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
