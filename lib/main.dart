import 'package:chat_app/Authentication/Views/Home%20Screens/new_screen.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/finish_screen.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/on_loading_one.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/on_loading_three.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/login.dart';
import 'package:chat_app/Authentication/Views/Splash_Screen/splash_screen.dart';
import 'package:chat_app/Authentication/Views/Update/update_profile.dart';
import 'package:chat_app/Authentication/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Authentication/Views/Home Screens/home_screen_one.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        OnLoadingOne.id : (context)  => OnLoadingOne(),
        OnLoadingTwo.id : (context) => OnLoadingTwo(),
        OtpScreen.id : (context) => OtpScreen(),
        FinishScreen.id :(context) => FinishScreen(),
        HomeScreen.id : (context) => HomeScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
        UpdateProfile.id : (context) => UpdateProfile(),
       // NewScreen.id : (context) => NewScreen(),
      },
    );
  }
}
