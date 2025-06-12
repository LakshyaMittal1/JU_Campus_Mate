// welcome.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String routeName = '/welcomePage';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFADAD),
        body: SafeArea(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, '/chatPage');
            },
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, -0.8),
                  child: Text(
                    'WELCOME!!!!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFBC041F),
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
  alignment: const Alignment(0, -0.3),
  child: Column(
    // mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'ASK YOUR QUERIES',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: const Color(0xFF960419),
          shadows: const [
            Shadow(
              color: Colors.black26,
              offset: Offset(1.0, 2.0),
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
      const SizedBox(height: 30),
      Text(
        'RELATED TO THE UNIVERSITY',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: const Color(0xFF960419),
          shadows: const [
            Shadow(
              color: Colors.black26,
              offset: Offset(1.0, 2.0),
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Text(
        'I AM HAPPY TO BE YOUR GUIDE!!',
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: const Color(0xFF960419),
          shadows: const [
            Shadow(
              color: Colors.black26,
              offset: Offset(1.0, 2.0),
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
    ],
  ),
),

                Align(
                  alignment: const Alignment(0, 0.46),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chatPage');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCC5D5D),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 32),
                      elevation: 0,
                      side: const BorderSide(
                        color: Color(0xFFE9DFDF),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'LET\'S GET STARTED ->',
                      style: GoogleFonts.interTight(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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