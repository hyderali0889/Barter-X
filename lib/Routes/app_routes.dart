import 'package:barter_x/Screens/Auth_Screens/reset_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/register_screen.dart';
import 'package:barter_x/Screens/Main_Screens/home_screen.dart';
import 'package:barter_x/Screens/Other_Screens/splash_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/login_screen.dart';
import '../Bindings/Auth_Bindings/login_bindings.dart';
import '../Bindings/Auth_Bindings/register_binding.dart';
import '../Bindings/Auth_Bindings/reset_binding.dart';
import './routes.dart';
import 'package:get/get.dart';

class AppRouter {
  List<GetPage> appRoutes = [
    GetPage(name: Routes().splashScreen, page: (() => const SplashScreen())),
    GetPage(name: Routes().homeScreen, page: (() => const HomeScreen())),
    GetPage(name: Routes().loginScreen, page: (() => const LoginScreen() ) , binding: LoginBinding()),
    GetPage(name: Routes().registerScreen, page: (() => const RegisterScreen() ) , binding: RegisterBinding()),
    GetPage(name: Routes().resetScreen, page: (() => const ResetScreen() ) , binding: ResetBinding()),
  ];
}
