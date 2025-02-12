import 'package:events/features/Introduction/presentation/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../auth/presentation/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {

      setState(() {
        loading = false;
          Get.off(IntroScreen());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "UniCom",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate().fade(duration: 500.ms).scale(),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.users, color: Colors.blueAccent, size: 32),
                SizedBox(width: 16),
                Icon(FontAwesomeIcons.commentDots, color: Colors.greenAccent, size: 32),
                SizedBox(width: 16),
                Icon(FontAwesomeIcons.calendar, color: Colors.purpleAccent, size: 32),
              ],
            ).animate().fade(duration: 500.ms, delay: 300.ms).moveY(begin: 20, end: 0),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Connect, Discuss, and Meet in One Place",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[300]),
              ),
            ).animate().fade(duration: 500.ms, delay: 600.ms),

            SizedBox(height: 30),
            if (loading)
              Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ).animate().fade(duration: 500.ms, delay: 900.ms),
          ],
        ),
      ),
    );
  }
}
