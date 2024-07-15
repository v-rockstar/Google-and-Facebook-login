import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snapchat/api/screen/home.dart';
import 'package:snapchat/auth/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapchat/auth/screens/my_homepage.dart';
import 'package:snapchat/helper/pref.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  await Hive.initFlutter().then((value) async => await Pref.initializeHive());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Snapchat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const Home(),
      // home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(
          () => Pref.skipIntro ? const MyHomePage() : const LandingScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
            height: 270,
            width: 270,
            image: NetworkImage(
                'http://2.bp.blogspot.com/-e8EX8HXfU_M/VWA1tOmIxII/AAAAAAAACnM/wVEAIqUlnOI/s1600/Snapchat-logo-vector.png')),
      ),
    );
  }
}
