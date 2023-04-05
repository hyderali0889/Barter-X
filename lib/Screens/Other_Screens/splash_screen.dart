import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation sizeAnimation;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    animation();
    getToLoginPage();
  }

  void getToLoginPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes().loginScreen);
    });
  }

  // Function for Animations

  void animation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        if (_controller.isCompleted) {
          _controller.repeat();
        }
      });
    sizeAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween(begin: 400.0, end: 350.0), weight: 150),
      TweenSequenceItem<double>(
          tween: Tween(begin: 350.0, end: 400.0), weight: 150),
    ]).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Main Build

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: sizeAnimation,
                builder: ((context, child) {
                  return Image.asset(
                    'assets/icons/Barter-X-logos_black.png',
                    width: sizeAnimation.value,
                  );
                }),
              )
            ]),
      )),
    );
  }
}
