import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/verify_email.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:second_hand_fashion_app/utils/exceptions/firebase_exception.dart';
import 'package:second_hand_fashion_app/utils/exceptions/format_exceptions.dart';
import 'package:second_hand_fashion_app/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  ///Called from main.dart on app launch
  @override
  void onReady() {
    //Loại bỏ màn hình chờ gốc
    FlutterNativeSplash.remove();
    //Chuyển hướng đến màn hình thích hợp
    screenRedirect();
  }

  ///Function xác định màn hình liên quan và chuyển hướng phù hợp
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      //neu nguoi dung da dang nhap
      if (user.emailVerified) {
        //neu email cua nguoi dung duoc xac minh => dieu huong den menu NavigationMenu
        Get.offAll(() => const NavigationMenu());
      } else {
        //neu email cua nguoi dung chua duoc xac minh => dieu huong den VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      //Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      //Kiểm tra xem đây có phải là lần đầu tiên khởi chạy ứng dụng không
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() =>
              const LoginScreen()) //Chuyển hướng đến LoginScreen nếu không phải lần đầu
          : Get.offAll(
              const OnBoardingScreen()); //chuyển hướng đến OnboardingScreen nếu đây là lần đầu tiên
    }
  }

  //----------------Email & Password sign-in-------------------//

  ///[EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///[EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[ReAuthentication] - ReAuthentication User
  ///[EmailVerification] Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - Forget Password

//----------------Federated identity & social sign-in-------------------//

  ///[GoogleAuthentication] - Google
  ///[FacebookAuthentication] - Facebook

//----------------./end Federated identity & social sign-in-------------------//

  ///[LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///DELETE USER - Remove user Auth and Firestore Account
}