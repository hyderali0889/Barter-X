import 'package:barter_x/Screens/Auth_Screens/route_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'Routes/app_routes.dart';
import 'Screens/Other_Screens/splash_screen.dart';
import 'Themes/app_theme.dart';
import 'Themes/main_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors().secRed));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barter X',
        theme: AppTheme().mainTheme,
        getPages: AppRouter().appRoutes,
        defaultTransition: Transition.leftToRightWithFade,
        home: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const RouteCheck();

          } else {
            return const SplashScreen();
          }
        } else {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Lottie.asset("assets/jsons/atom-loader.json" , width:420 , height:420)
            ),
          );
        }
      },
    );
  }
}
