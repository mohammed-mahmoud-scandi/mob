import 'package:mr_muscle_trainee/Home.dart';
import 'package:flutter/material.dart';
import 'package:mr_muscle_trainee/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));

  FlutterNativeSplash.remove();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        color: Colors.blue,
        theme: ThemeData.light(),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const Home(), // Replace with your home screen class
        },

        home: const SplashScreen()
    );
  }
}
