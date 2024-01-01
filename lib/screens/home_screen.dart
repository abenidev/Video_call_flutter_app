import 'package:flutter/material.dart';
import 'package:video_chat_app/components/custom_button.dart';
import 'package:video_chat_app/resources/auth_methods.dart';
import 'package:video_chat_app/screens/meeting_history_screen.dart';
import 'package:video_chat_app/screens/meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const MeetingScreen(),
    const MeetingHistoryScreen(),
    // const Text('Contacts'),
    //setting
    CustomButton(label: "Log out", onPressed: () => AuthMethods().signOut()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
        // backgroundColor: backgroundColor,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: footerColor,
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.grey,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: 'Meet & Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Meetings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: 'Contacts',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
