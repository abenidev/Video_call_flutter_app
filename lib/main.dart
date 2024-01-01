import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_chat_app/firebase_options.dart';
import 'package:video_chat_app/resources/auth_methods.dart';
import 'package:video_chat_app/screens/home_screen.dart';
import 'package:video_chat_app/screens/login_screen.dart';
import 'package:video_chat_app/screens/video_call_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video chat app',
      // theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        VideoCallScreen.routeName: (context) => const VideoCallScreen(),
      },
      // initialRoute: LoginScreen.routeName,
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
