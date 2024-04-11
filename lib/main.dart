
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {

  ///Widgets Building
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///GetX Local Storage
  await GetStorage.init();

  ///Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()),
//lý do để thực hiện AuthenticationRepository là để kích hoạt chức năng ready của kho lưu trữ xác thực
  );

  runApp(const App());
}
