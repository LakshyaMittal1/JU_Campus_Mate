/* //main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ju_campus_mate/chatpage.dart';
import 'package:ju_campus_mate/homepage.dart';
import 'package:ju_campus_mate/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JU Campus Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const HomePage(),routes: {
        '/welcomePage': (context) => const WelcomePage(),
        '/chatPage': (context) => const ChatPage(), // <-- Placeholder
      },
);
}
} */

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'chatpage.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}
