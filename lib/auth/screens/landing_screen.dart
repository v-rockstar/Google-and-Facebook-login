import 'package:flutter/material.dart';
import '../repository/sign_in.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          const Image(
              height: 170,
              width: 170,
              image: NetworkImage(
                  'http://2.bp.blogspot.com/-e8EX8HXfU_M/VWA1tOmIxII/AAAAAAAACnM/wVEAIqUlnOI/s1600/Snapchat-logo-vector.png')),
          const SizedBox(height: 170),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                elevation: 7,
                height: 50,
                minWidth: 90,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.white,
                onPressed: () => SignIn().googleSignInfnc(),
                child: const Row(
                  children: [
                    Text('Login with'),
                    Image(
                      image: NetworkImage(
                          'https://4.bp.blogspot.com/-K1IdqgDmrJU/W1tubjO-LrI/AAAAAAAABN4/kIB_xbkes2MMSxqXF7gBxuJSr4FDuufPwCLcBGAs/s1600/Google-logo-2015-G-icon.png',
                          scale: 30),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                elevation: 7,
                height: 50,
                minWidth: 90,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.blue,
                onPressed: () => SignIn().facebookLogin(),
                child: const Row(
                  children: [
                    Text('Login with'),
                    SizedBox(width: 15),
                    Icon(
                      Icons.facebook,
                      size: 27,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
