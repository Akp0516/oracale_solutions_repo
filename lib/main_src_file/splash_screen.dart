import 'package:flutter/material.dart';

import 'main_tab_section.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  // Delay the zoom-in animation and navigate to the next screen
  Future<void> _startSplashScreen() async {
    await Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        _scale = 5.0; // zoom-in effect
      });
    });

    // Wait a bit before transitioning to the next screen
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OracleSolutionsPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                // shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/new_logo.jpeg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
