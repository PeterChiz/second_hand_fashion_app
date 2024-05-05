import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/signup.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/verify_email.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/profile.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/settings/settings.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/cart.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/checkout.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/home.dart';
import 'package:second_hand_fashion_app/features/shop/screens/order/order.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/store.dart';
import 'package:second_hand_fashion_app/routes/routes.dart';

import '../features/shop/screens/favourites/favourite.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: SHFRoutes.home, page: () => const HomeScreen()),
    GetPage(name: SHFRoutes.store, page: () => const StoreScreen()),
    GetPage(name: SHFRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: SHFRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: SHFRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: SHFRoutes.order, page: () => const OrderScreen()),
    GetPage(name: SHFRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: SHFRoutes.cart, page: () => const CartScreen()),
    GetPage(name: SHFRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: SHFRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: SHFRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: SHFRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: SHFRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: SHFRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: SHFRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];

}