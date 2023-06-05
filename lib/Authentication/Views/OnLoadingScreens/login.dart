import 'package:chat_app/Authentication/Views/Home%20Screens/Welcome_Screen.dart';
import 'package:chat_app/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/my_text_field.dart';
import '../../sign_up.dart';
import '../Home Screens/home_screen_one.dart';
// import 'on_loading_three.dart';

class OnLoadingTwo extends StatefulWidget {
  static const String id = "on_loading_two";
  const OnLoadingTwo({Key? key}) : super(key: key);

  @override
  State<OnLoadingTwo> createState() => _OnLoadingTwoState();
}

class _OnLoadingTwoState extends State<OnLoadingTwo> {
  final TextEditingController  _emailcontroller =  TextEditingController();
  final TextEditingController  _passwordcontroller =  TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  //height: height * 0.0446428571428571,
                ),
                Container(
                  height: 150,
                  //height: height * 0.0591517857142857,
                  width: 150,
                  //width: width * 0.1280193236714976,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        image: AssetImage("assets/chatify.png"),
                        fit: BoxFit.fill,
                      )
                  ),

                ),
                SizedBox(
                   height: 60,
                  //height: height * 0.0625,
                ),


                MyTextField(
                  keytype: TextInputType.emailAddress,
                  hinttext: 'Enter your Email',
                  prefixicon: Icons.email_outlined,
                  controller: _emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your email";
                    }
                    if (!RegExp(
                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "please enter a Valid email";
                    }
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                MyTextField(
                  obs: true,
                    controller: _passwordcontroller,
                    hinttext: "Enter password",
                    prefixicon: Icons.lock_outline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter Password";
                    }
                    if (value.length < 8) {
                      return "password must have 8 characters  ";
                    }

                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(right: 20),
                //       child: TextButton(onPressed: (){
                //
                //       }, child: Text("Forgot Password?",style: TextStyle(
                //         fontWeight: FontWeight.w400,
                //         // fontSize: 18,
                //         fontSize: (height * 0.0200892857142857/2 + width * 0.0434782608695652/2),
                //         color: Color(0xff002020),
                //       ),)),
                //     ),
                //   ],
                // ),




                // Container(
                //    height: 64,
                //   //height: height * 0.078125,
                //    width: 250,
                //   //width: width * 0.7971014492753623,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     color: Colors.white,
                //   ),
                //   child: Center(
                //     child: Padding(
                //       padding:  EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         keyboardType: TextInputType.number,
                //         style: TextStyle(
                //           fontSize: 25,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.black,
                //         ),
                //         decoration: InputDecoration(
                //           focusedBorder: InputBorder.none,
                //           border: InputBorder.none,
                //           hintText: "Enter Your Number",
                //           hintStyle: TextStyle(
                //             fontSize: 25,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                   height: 60,
                  //height: height * 0.1116071428571429,
                ),
                InkWell(
                  onTap: ()async{
                    if(formkey.currentState!.validate()) {
                      String email = _emailcontroller.text.trim();
                      String pass = _emailcontroller.text.trim();


                      // await FirebaseServices.login(email, pass);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreenOne()));
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailcontroller.text.trim(),
                            password: _passwordcontroller.text.trim()).whenComplete((){

                          //Navigator.pushNamed(context, OtpScreen.id);
                        }).then((value) {
                          if(value.user!.uid!=""){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreenOne()));
                          }
                        });
                    }else
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Login Error',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          content: Text(
                            'Please fill the fields correctly',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    /*else {
                      // final snackBar = SnackBar(content: const Text(
                      //     "Please fill above fields correctly",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 25,
                      //     color: Color(0xffffffff),
                      //   ),
                      // ));
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //
                      // print("fill above fields correctly");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Login Error',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            content: Text(
                              'Please fill the fields correctly',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    }*/
                      // Navigator.pushNamed(context, OtpScreen.id);
                  },
                  child: Container(
                    height: 60,
                    //height: height * 0.0714285714285714,
                    width: 130,
                    //width: width * 0.4347826086956522,
                    decoration: BoxDecoration(
                      color: Color(0xffACDDDE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  Center(
                      child: Text("Log In",style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20,
                      ),),
                    ),
                  ),
                ),

                SizedBox(
                  height: 70,
                  //height: height * 0.1004464285714286,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?",style: TextStyle(
                      // fontSize: 18,
                      fontSize: (height * 0.0200892857142857/2 + width * 0.0434782608695652/2),
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7E7E7E),
                    ),),

                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SignUpScreen.id);
                        }, child: Text(" Register Now. ",style: TextStyle(

                      fontWeight: FontWeight.w500,
                      // fontSize: 18,
                      fontSize: (height * 0.0200892857142857/2 + width * 0.0434782608695652/2),
                      color: Color(0xff008080),
                    ),))
                    // TextButton(onPressed: (){
                    //
                    // }, child: Text("  Register Now.",style: TextStyle(
                    //   fontWeight: FontWeight.w500,
                    //   fontSize: 18,
                    //   color: Color(0xffFF2156),
                    // ),))
                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
