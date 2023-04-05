import 'package:barter_x/Screens/Main_Screens/home_screen.dart';
import 'package:barter_x/Screens/Other_Screens/splash_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/login_screen.dart';
import '../Bindings/Auth_Bindings/login_bindings.dart';
import './routes.dart';
import 'package:get/get.dart';

class AppRouter {
  List<GetPage> appRoutes = [
    GetPage(name: Routes().splashScreen, page: (() => const SplashScreen())),
    GetPage(name: Routes().homeScreen, page: (() => const HomeScreen())),
    GetPage(name: Routes().loginScreen, page: (() => const LoginScreen() ) , binding: LoginBinding()),
  ];
}
