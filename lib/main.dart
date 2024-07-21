import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snapchat/router/router_x.dart';
import 'api/cubit/api_cubit.dart';
import 'api/screen/home.dart';
import 'api2.0.dart/screen/cat.dart';
import 'auth/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/screens/my_homepage.dart';
import 'helper/pref.dart';
import 'pact.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  await Hive.initFlutter().then((value) async => await Pref.initializeHive());
  await dotenv.load(fileName: ".env");
  if (kDebugMode) {
    log('ye hai debug mode me');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Snapchat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      routerConfig: RouterX.router,

      // home:
      // const CategoryScreen()
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
      RouterX.router.goNamed(RouteName.home.name);
      // Get.off(
      //     () => Pref.skipIntro ? const MyHomePage() : const LandingScreen());
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
