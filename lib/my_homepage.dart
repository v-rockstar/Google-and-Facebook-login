import 'package:flutter/material.dart';
import 'package:snapchat/landing_screen.dart';
import 'package:snapchat/repository.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Repository().signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LandingScreen(),
                      ));
                },
                child: const Text('Google Logout')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Repository().fbSignOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LandingScreen(),
                      ));
                },
                child: const Text('Facebook Logout')),
          ),
        ],
      ),
    );
  }
}
