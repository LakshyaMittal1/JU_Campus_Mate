// homepage.dart

import 'package:flutter/material.dart';
import 'package:ju_campus_mate/welcome.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 15000), () {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFADAD),
        body: SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.02, -0.17),
                  child: GradientText(
                    '           JU\nCAMPUS MATE',
                    style: TextStyle(
                      fontSize: 49,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF8FDFF),
                      shadows: List.generate(
                        4,
                        (index) => const Shadow(
                          color: Colors.black45,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ),
                    ),
                    colors: const [
                      Color(0xFF920F3B),
                      Color(0xFFE1212B),
                      Color(0xFFDE1F4D),
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0.01, 0.57),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/chatbot.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.03, -0.59),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.careerindia.com/college-photos/31798/ju-logo_1672931348.png',
                      width: 260,
                      height: 102.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
