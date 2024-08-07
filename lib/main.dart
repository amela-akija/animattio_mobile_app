
import 'package:animattio_mobile_app/firebase_options.dart';
import 'package:animattio_mobile_app/localization/localization_service.dart';
import 'package:animattio_mobile_app/pages/login_page.dart';
import 'package:animattio_mobile_app/pages/main_page.dart';
import 'package:animattio_mobile_app/poviders/images_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(ChangeNotifierProvider(
      create: (context) => ImagesProvider(),
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations:LocalizationService(),
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale: Locale('en', ''),
      home:MainPage(),
    );
  }
}
