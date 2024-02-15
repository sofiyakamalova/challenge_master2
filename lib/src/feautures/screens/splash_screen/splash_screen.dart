import 'package:challenge_master/src/feautures/screens/nav_pages/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 220,
            ),
          ),
          Container(height: 5),
          const Center(
            child: Column(
              children: [
                Text(
                  'Challenger App',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
