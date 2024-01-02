import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:video_chat_app/resources/auth_methods.dart';
import 'package:video_chat_app/screens/home_screen.dart';
import 'package:video_chat_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late StreamSubscription userChangeSubscription;

  @override
  void initState() {
    super.initState();
    startListener();
  }

  void startListener() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    userChangeSubscription = _authMethods.authChanges.listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  void dispose() {
    userChangeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: RiveAnimation.asset('assets/bulb_logo.riv'),
          ),
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: Text('abeni.dev', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
