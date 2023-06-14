import 'package:barter_x/Bindings/Main_Bindings/Trade_and_EWaste_Bindings/category_details_bindings.dart';
import 'package:barter_x/Bindings/Main_Bindings/Trade_and_EWaste_Bindings/confirmation_bindings.dart';
import 'package:barter_x/Bindings/Main_Bindings/Trade_and_EWaste_Bindings/product_details_binding.dart';
import 'package:barter_x/Bindings/Main_Bindings/Auction_Bindings/auction_category_details_bindings.dart';
import 'package:barter_x/Bindings/Main_Bindings/Auction_Bindings/auction_product_details_binding.dart';
import 'package:barter_x/Screens/Auth_Screens/otp_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/phone_auth.dart';
import 'package:barter_x/Screens/Auth_Screens/reset_screen.dart';
import 'package:barter_x/Screens/Auth_Screens/register_screen.dart';
import 'package:barter_x/Screens/Main_Screens/Forms/auction_form.dart';
import 'package:barter_x/Screens/Main_Screens/Trade_and_EWaste_SubPages/Trade_Screens/trade_arrivals.dart';
import 'package:barter_x/Screens/Main_Screens/Trade_and_EWaste_SubPages/Trade_Screens/trade_featured.dart';
import 'package:barter_x/Screens/Main_Screens/Trade_and_EWaste_SubPages/Trade_Screens/trade_specials.dart';
import 'package:barter_x/Screens/Main_Screens/Trade_and_EWaste_SubPages/categories_detail_screen.dart';
import 'package:barter_x/Screens/Main_Screens/Trade_and_EWaste_SubPages/product_details_screen.dart';
import 'package:barter_x/Screens/Other_Screens/change_password.dart';
import 'package:barter_x/Screens/Other_Screens/confirmation_screen.dart';
import 'package:barter_x/Screens/Other_Screens/ratings_screen.dart';
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
import '../Bindings/Main_Bindings/Form_Bindings/bid_form_binding.dart';
import '../Bindings/Main_Bindings/Form_Bindings/ewaste_form_bindings.dart';
import '../Bindings/Main_Bindings/Form_Bindings/trade_form_bindings.dart';
import '../Bindings/Main_Bindings/Navigation_bindings/navigation_binding.dart';
import '../Bindings/Main_Bindings/Other_Bindings/search_binding.dart';
import '../Bindings/Main_Bindings/Trade_and_EWaste_Bindings/ratings_bindings.dart';
import '../Screens/Main_Screens/Auction_SubPages/Auction_Screens/auction_arrivals.dart';
import '../Screens/Main_Screens/Auction_SubPages/Auction_Screens/auction_featured.dart';
import '../Screens/Main_Screens/Auction_SubPages/Auction_Screens/auction_specials.dart';
import '../Screens/Main_Screens/Auction_SubPages/auction_categories_detail_screen.dart';
import '../Screens/Main_Screens/Auction_SubPages/auction_product_details_screen.dart';
import '../Screens/Main_Screens/Forms/bid_form.dart';
import '../Screens/Main_Screens/Forms/e_waste_form.dart';
import '../Screens/Main_Screens/Forms/trade_form.dart';
import '../Screens/Other_Screens/all_auctions.dart';
import '../Screens/Other_Screens/all_bids.dart';
import '../Screens/Other_Screens/all_ewastes.dart';
import '../Screens/Other_Screens/all_trades.dart';
import '../Screens/Other_Screens/search_screen.dart';
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
    GetPage(name: Routes().allTrades, page: (() => const AllTradesScreen())),
    GetPage(name: Routes().allAuctions, page: (() => const AllAuctionsScreen())),
    GetPage(name: Routes().allEWastes, page: (() => const AllEWasteScreen())),
    GetPage(name: Routes().allBids, page: (() => const AllBidsScreen())),
    GetPage(name: Routes().changePassword, page: (() => const ChangePasswordScreen())),
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

    //Forms

    GetPage(
        name: Routes().addTradeForm,
        page: (() => const TradeForm()),
        binding: TradeFormBinding()),

    GetPage(
        name: Routes().addAuctionForm,
        page: (() => const AuctionForm()),
        binding: AuctionFormBinding()),

    GetPage(
        name: Routes().addEWasteForm,
        page: (() => const EWasteForm()),
        binding: EWasteFormBinding()),
    GetPage(
        name: Routes().addBidForm,
        page: (() => const BidForm()),
        binding: BidFormBinding()),

    // Sub Trade Routes
    GetPage(name: Routes().tradeFeature, page: () => const TradeFeatures()),
    GetPage(name: Routes().tradeArrivals, page: () => const TradeArrivals()),
    GetPage(name: Routes().tradeSpecials, page: () => const TradeSpecials()),
    // Auction Sub Trade Routes
    GetPage(
        name: Routes().auctionTradeFeature,
        page: () => const AuctionFeatures()),
    GetPage(
        name: Routes().auctionTradeArrivals,
        page: () => const AuctionArrivals()),
    GetPage(
        name: Routes().auctionTradeSpecials,
        page: () => const AuctionSpecials()),

    // Trade Details Screens
    GetPage(
        name: Routes().categoryDetails,
        page: () => (const CategoryDetailScreen()),
        binding: CategoryDetailsBindings()),
    GetPage(
        name: Routes().productDetails,
        page: () => (const ProductDetailScreen()),
        binding: ProductDetailsBindings()),
    // Auction Details Screens
    GetPage(
        name: Routes().auctionCategoryDetails,
        page: () => (const AuctionCategoryDetailScreen()),
        binding: AuctionCategoryDetailsBindings()),
    GetPage(
        name: Routes().auctionProductDetails,
        page: () => (const AuctionProductDetailScreen()),
        binding: AuctionProductDetailsBindings()),

    GetPage(
        name: Routes().confirmationScreen,
        page: () => const ConfirmationScreen(),
        binding: ConfirmationBindings()),
    GetPage(
        name: Routes().ratingsScreen,
        page: () => const RatingsScreen(),
        binding: RatingsBindings()),
    GetPage(
        name: Routes().searchScreen,
        page: () => const SearchScreen(),
        binding: SearchBinding()),
    //ENd of Routes
  ];
}
