import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sneaker_store_app/Widgets/userOnboarding/login.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer( const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.blue[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/icons/project_logo.png'), 
           const Text('An inspiration for sneakerheads')
          ],
        ),
      ),
    );
  }
}
