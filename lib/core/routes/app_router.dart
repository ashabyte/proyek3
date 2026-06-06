import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/auth/sign_up_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/services/printing_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/search/yearbook_concept_screen.dart';
import '../../shared/models/tema_model.dart';
import '../../features/referensi/referensi_screen.dart';
import '../../features/lokasi/lokasi_screen.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/cart/cart_select_screen.dart';
import '../../features/checkout/checkout_screen.dart';
import '../../features/checkout/select_payment_screen.dart';
import '../../features/checkout/select_datetime_screen.dart';
import '../../features/checkout/success_payment_screen.dart';
import '../../features/checkout/receipt_screen.dart';
import '../../features/details/details_screen.dart';
import '../../features/booking/booking_upcoming_screen.dart';
import '../../features/booking/booking_completed_screen.dart';
import '../../features/booking/booking_cancelled_screen.dart';
import '../../features/account/account_screen.dart';
import '../../features/account/edit_account_screen.dart';
import '../../features/account/change_password_screen.dart';
import '../../features/account/settings_screen.dart';
import '../../features/chatbot/chatbot_ai_screen.dart';
import '../../shared/widgets/main_scaffold.dart';
import '../../features/tema/tema_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String printing = '/printing';
  static const String designGraphic = '/design-graphic';
  static const String photography = '/photography';
  static const String search = '/search';
  static const String tema = '/tema';
  static const String referensi = '/referensi';
  static const String lokasi = '/lokasi';
  static const String cart = '/cart';
  static const String cartSelect = '/cart-select';
  static const String checkout = '/checkout';
  static const String selectPayment = '/select-payment';
  static const String selectDatetime = '/select-datetime';
  static const String successPayment = '/success-payment';
  static const String receiptPayment = '/receipt-payment';
  static const String details = '/details';
  static const String bookingUpcoming = '/booking-upcoming';
  static const String bookingCompleted = '/booking-completed';
  static const String bookingCancelled = '/booking-cancelled';
  static const String account = '/account';
  static const String editAccount = '/edit-account';
  static const String changePassword = '/change-password';
  static const String settings = '/settings';
  static const String chatbotAi = '/chatbot-ai';
  static const String yearbookConcept = '/yearbook-concept';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: AppRoutes.account,
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.printing,
      builder: (context, state) => const PrintingScreen(),
    ),
    GoRoute(
      path: AppRoutes.designGraphic,
      builder: (context, state) => const DesignGraphicScreen(),
    ),
    GoRoute(
      path: AppRoutes.photography,
      builder: (context, state) => const PhotographyScreen(),
    ),
    GoRoute(
  path: AppRoutes.details,
  builder: (context, state) => DetailsScreen(
    tema: state.extra as TemaItem?,
      ),
    ),
    GoRoute(
      path: AppRoutes.referensi,
      builder: (context, state) => const ReferensiScreen(),
    ),
    GoRoute(
      path: AppRoutes.lokasi,
      builder: (context, state) => const LokasiScreen(),
    ),
    GoRoute(
      path: AppRoutes.cartSelect,
      builder: (context, state) => const CartSelectScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.selectPayment,
      builder: (context, state) => const SelectPaymentScreen(),
    ),
    GoRoute(
      path: AppRoutes.selectDatetime,
      builder: (context, state) => const SelectDatetimeScreen(),
    ),
    GoRoute(
      path: AppRoutes.successPayment,
      builder: (context, state) => const SuccessPaymentScreen(),
    ),
    GoRoute(
      path: AppRoutes.receiptPayment,
      builder: (context, state) => const ReceiptScreen(),
    ),
    GoRoute(
      path: AppRoutes.details,
      builder: (context, state) => const DetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.bookingUpcoming,
      builder: (context, state) => const BookingUpcomingScreen(),
    ),
    GoRoute(
      path: AppRoutes.bookingCompleted,
      builder: (context, state) => const BookingCompletedScreen(),
    ),
    GoRoute(
      path: AppRoutes.bookingCancelled,
      builder: (context, state) => const BookingCancelledScreen(),
    ),
    GoRoute(
      path: AppRoutes.editAccount,
      builder: (context, state) => const EditAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.chatbotAi,
      builder: (context, state) => const ChatbotAiScreen(),
    ),
    GoRoute(
      path: AppRoutes.yearbookConcept,
      builder: (context, state) => const YearbookConceptScreen(),
    ),
    GoRoute(
      path: AppRoutes.tema,
      builder: (context, state) => const TemaScreen(),
    ),
  ],
);