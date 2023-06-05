import 'package:chat_app/Authentication/Views/OnLoadingScreens/login.dart';
import 'package:chat_app/Authentication/sign_up.dart';
import 'package:flutter/material.dart';

class OnLoadingOne extends StatefulWidget {
  static const String id = "on_loading_one";
  const OnLoadingOne({Key? key}) : super(key: key);

  @override
  State<OnLoadingOne> createState() => _OnLoadingOneState();
}
    double height = 0;
    double width = 0;
class _OnLoadingOneState extends State<OnLoadingOne> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                // height: 40,
                height: height * 0.0446428571428571,
              ),
              Container(
                // height: 53,
                height: height * 0.0591517857142857,
                // width: 53,
                width: width * 0.1280193236714976,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/chatify.png"),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              SizedBox(
                // height: 56,
                height: height * 0.0625,
              ),
              Container(
                // height: 309.07,
                  height: height * 0.3449441964285714,
                // width: 271.96,
                width: width * 0.6569082125603865,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage("assets/chatifyy.png"),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              SizedBox(
                // height: 47.93,
                height: height * 0.0534933035714286,
              ),
              Container(
                // height: 100,
                height: height * 0.1116071428571429,
                // width: 276,
                width: width * 0.6666666666666667,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Explore Dreams",style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.black,
                    ),),
                    Text("Discover Enjoy",style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.black,
                    ),),
                  ],
                ),
              ),
              SizedBox(
                // height: 17,
                height: height * 0.0189732142857143,
              ),
              Container(
                // height: 62,
                height: height * 0.0691964285714286,
                // width: 320,
                width: width * 0.7729468599033816,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Use this application and get real",style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),),
                    Text("experience of your chatting",style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),)
                  ],
                ),
              ),
              SizedBox(
                 //height: 70,
                height: height * 0.078125,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, OnLoadingTwo.id);
                        },
                        child: Container(
                          // height: 64,
                          height: height * 0.0714285714285714,
                          //width: 120,
                          width: width * 0.2898550724637681,
                          decoration: BoxDecoration(
                            color: Color(0xffACDDDE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text("SIGN IN",style: TextStyle(
                                fontWeight: FontWeight.w700,
                                //fontFamily: 'Arima',
                                color: Colors.black,
                                fontSize: 20,
                            ),),
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Container(
                        // height: 64,
                        height: height * 0.0714285714285714,
                         //width: 120,
                        width: width * 0.2898550724637681,
                        decoration: BoxDecoration(
                          color: Color(0xffACDDDE),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text("SIGN UP",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 20,
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
