import 'package:barter_x/Screens/Auth_Screens/reset_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/register_screen.dart';
import 'package:barter_x/Screens/Main_Screens/home_screen.dart';
import 'package:barter_x/Screens/Other_Screens/splash_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/login_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/email_verification.dart';
import '../Bindings/Auth_Bindings/login_bindings.dart';
import '../Bindings/Auth_Bindings/register_binding.dart';
import '../Bindings/Auth_Bindings/reset_binding.dart';
import '../Bindings/Auth_Bindings/email_verification_binding.dart';
import './routes.dart';
import 'package:get/get.dart';

class AppRouter {
  List<GetPage> appRoutes = [

    // Other Screens
    GetPage(name: Routes().splashScreen, page: (() => const SplashScreen())),
    // Auth Screens
    GetPage(name: Routes().loginScreen, page: (() => const LoginScreen() ) , binding: LoginBinding()),
    GetPage(name: Routes().registerScreen, page: (() => const RegisterScreen() ) , binding: RegisterBinding()),
    GetPage(name: Routes().resetScreen, page: (() => const ResetScreen() ) , binding: ResetBinding()),
    GetPage(name: Routes().emailVerificationScreen, page: (() => const EmailVerificationScreen() ) , binding: EmailVerificationBinding() ),
    // Main Screens
    GetPage(name: Routes().homeScreen, page: (() => const HomeScreen())),
  ];
}
