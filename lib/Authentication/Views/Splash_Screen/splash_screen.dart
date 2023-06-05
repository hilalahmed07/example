import 'dart:async';

import 'package:chat_app/Authentication/Views/Home%20Screens/home_screen_one.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/on_loading_one.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final User? user = auth.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(FirebaseAuth.instance.currentUser != null){
    //   Timer(Duration(seconds: 5),(){
    //     Navigator.pushNamed(context, HomeScreen.id);
    //   });
    // }
    // else{
    //   Timer(Duration(seconds: 5), () {
    //     Navigator.pushNamed(context, OnLoadingOne.id);
    //   });
    // }
    Timer(Duration(seconds: 5), () {
           Navigator.pushNamed(context, OnLoadingOne.id);
        });


  }



  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
     height = MediaQuery.of(context).size.height;
     width = MediaQuery.of(context).size.width;

     print("height of mobile is $height");
     print("width of mobile is $width");
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height,
          width: width,
          child:  Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // height: 330,
                    height: height * 0.3683035714285714,
                  ),
                  Container(
                    // height: 100,
                    // width: 100,
                    height: height* 0.1116071428571429,
                    width: width*0.2415458937198068,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/chatify.png"),
                          fit: BoxFit.fill,
                        )
                    ),

                  ),
                  SizedBox(
                    // height: 370,
                    height: height * 0.4129464285714286,
                  ),
                  Container(
                    // height: 48,
                    height: height * 0.0535714285714286,
                    // width: 86,
                    width: width * 0.2077294685990338,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("from",style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff111115)
                        ),),
                      Image.asset("assets/meta.png",fit: BoxFit.cover,height: height * 0.0334821428571429,width: width *  0.2077294685990338,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
