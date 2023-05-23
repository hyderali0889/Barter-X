import 'package:barter_x/Screens/Auth_Screens/otp_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/phone_auth.dart';
import 'package:barter_x/Screens/Auth_Screens/reset_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/register_screen.dart';
import 'package:barter_x/Screens/Main_Screens/Forms/auction_form.dart';
import 'package:barter_x/Screens/Other_Screens/splash_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/login_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/email_verification.dart';
import 'package:barter_x/Screens/Main_Screens/Navigation/route_check.dart';
import 'package:barter_x/Screens/Main_Screens/Navigation/navigation_screen.dart';
import '../Bindings/Auth_Bindings/login_bindings.dart';
import '../Bindings/Auth_Bindings/otp_binding.dart';
import '../Bindings/Auth_Bindings/phone_auth_bindings.dart';
import '../Bindings/Auth_Bindings/register_binding.dart';
import '../Bindings/Auth_Bindings/reset_binding.dart';
import '../Bindings/Auth_Bindings/email_verification_binding.dart';
import '../Bindings/Main_Bindings/Form_Bindings/auction_form_bindings.dart';
import '../Bindings/Main_Bindings/Form_Bindings/ewaste_form_bindings.dart';
import '../Bindings/Main_Bindings/Form_Bindings/trade_form_bindings.dart';
import '../Bindings/Main_Bindings/Navigation_bindings/navigation_binding.dart';
import '../Screens/Main_Screens/Forms/e_waste_form.dart';
import '../Screens/Main_Screens/Forms/trade_form.dart';
import './routes.dart';
import 'package:get/get.dart';

class AppRouter {
  List<GetPage> appRoutes = [

    /*
         dP"Yb  888888 88  88 888888 88""Yb     .dP"Y8  dP""b8 88""Yb 888888 888888 88b 88 .dP"Y8
        dP   Yb   88   88  88 88__   88__dP     `Ybo." dP   `" 88__dP 88__   88__   88Yb88 `Ybo."
        Yb   dP   88   888888 88""   88"Yb      o.`Y8b Yb      88"Yb  88""   88""   88 Y88 o.`Y8b
         YbodP    88   88  88 888888 88  Yb     8bodP'  YboodP 88  Yb 888888 888888 88  Y8 8bodP'
    */

    GetPage(name: Routes().splashScreen, page: (() => const SplashScreen())),
    // Auth Screens
    GetPage(
        name: Routes().loginScreen,
        page: (() => const LoginScreen()),
        binding: LoginBinding()),
    GetPage(
        name: Routes().registerScreen,
        page: (() => const RegisterScreen()),
        binding: RegisterBinding()),
    GetPage(
        name: Routes().resetScreen,
        page: (() => const ResetScreen()),
        binding: ResetBinding()),
    GetPage(
        name: Routes().phoneAuthScreen,
        page: (() => const PhoneAuthScreen()),
        binding: PhoneBinding()),
    GetPage(
        name: Routes().emailVerificationScreen,
        page: (() => const EmailVerificationScreen()),
        binding: EmailVerificationBinding()),
    GetPage(
        name: Routes().otpScreen,
        page: (() => const OTPScreen()),
        binding: OTPBinding()),

    // Navigation Screen

    GetPage(
      name: Routes().routeCheck,
      page: (() => const RouteCheck()),
    ),
    GetPage(
        name: Routes().navigationScreen,
        page: (() => const NavigationScreen()),
        binding: NavigationBinding()),

    // Main Screens

    // GetPage(name: Routes().homeScreen, page: (() => const HomeScreen())),
    // GetPage(name: Routes().auctionScreen, page: (() => const AuctionScreen())),
    // GetPage(name: Routes().eWasteScreen, page: (() => const EWasteScreen())),
    // GetPage(name: Routes().notificationScreen, page: (() => const NotificationScreen() ) , binding: NotificationBinding()),
    // GetPage(name: Routes().profileScreen, page: (() => const ProfileScreen())),

    //Forms

    GetPage(
      name: Routes().addTradeForm,
      page: (() => const TradeForm()
      ),binding: TradeFormBinding()
    ),

    GetPage(
      name: Routes().addAuctionForm,
      page: (() => const AuctionForm()
      ),binding: AuctionFormBinding()
    ),

    GetPage(
      name: Routes().addEWasteForm,
      page: (() => const EWasteForm()
      ),binding: EWasteFormBinding()
    ),
  ];
}
