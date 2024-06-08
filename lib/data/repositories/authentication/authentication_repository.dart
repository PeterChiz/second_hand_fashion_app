import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/verify_email.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:second_hand_fashion_app/utils/exceptions/firebase_exception.dart';
import 'package:second_hand_fashion_app/utils/exceptions/format_exceptions.dart';
import 'package:second_hand_fashion_app/utils/exceptions/platform_exceptions.dart';
import 'package:second_hand_fashion_app/utils/local_storage/storage_utility.dart';

import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  String get getUserEmail => _firebaseUser.value?.email ?? "";

  String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  String get getPhoneNo => _firebaseUser.value?.phoneNumber ?? "";

  ///Được gọi từ main.dart khi khởi chạy ứng dụng
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    screenRedirect(_firebaseUser.value);
  }

  ///Function xác định màn hình liên quan và chuyển hướng phù hợp
   screenRedirect(User? user) async {
    if (user != null) {
      // User Logged-In: If email verified let the user go to Home Screen else to the Email Verification Screen
      if (user.emailVerified) {
        // Initialize User Specific Storage
        await SHFLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: getUserEmail));
      }
    } else {
      // Local Storage: User is new or Logged out! If new then write isFirstTime Local storage variable = true.
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnBoardingScreen());
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
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
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
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }

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
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }


  ///[EmailAuthentication] - Quen mat khau
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }

  ///[ReAuthentication] - Re-Authentication User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      //Tạo thông tin xác thực
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }


//----------------Federated identity & social sign-in-------------------//

  ///[GoogleAuthentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Kich hoat luong xac thuc
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Lay chi tiet xac thuc tu ban dau
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //tao thong tin xac thuc moi
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //sau khi dang nhap, return UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode) print('Đã có xảy ra lỗi: $e');
      return null;
    }
  }


//----------------./end Federated identity & social sign-in-------------------//

  ///[LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
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
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }

  ///DELETE USER - Xóa user Auth và Firestore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw SHFFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã có lỗi gì đó, vui lòng thử lại!';
    }
  }
}
