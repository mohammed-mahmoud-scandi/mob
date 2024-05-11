import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the home screen after 3 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()),
      );
    });
  }
  @override
  void dispose(){
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Your app logo or image here
              Image.asset(
                'assets/logo.jpg',
              ),
              // Add a progress indicator or loading text (optional)
              CircularProgressIndicator(
                color: Colors.yellow[400],
              ),
            ],
          ),
        )
      ),
    );
  }
}
