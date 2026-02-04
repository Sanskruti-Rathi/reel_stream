import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:reel_stream/constants.dart';
import 'package:reel_stream/controllers/auth_controller.dart';
import 'package:reel_stream/firebase_options.dart';
import 'package:reel_stream/views/widgets/screens/auth/login_screen.dart';
import 'package:reel_stream/views/widgets/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:reel_stream/views/widgets/screens/home_screen.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp().then((value){
      Get.put(AuthController());
      
});*/

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then( (value){
      Get.put(AuthController());});
  runApp(
    DevicePreview(
      enabled : true,
      builder :  (context) => const MyApp()
    )
    //const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'ReelStream',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}

