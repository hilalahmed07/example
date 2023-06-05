import 'dart:io';

import 'package:chat_app/Authentication/Views/OnLoadingScreens/on_loading_one.dart';
import 'package:chat_app/Authentication/Views/OnLoadingScreens/login.dart';
import 'package:chat_app/Authentication/constants/my_text_field.dart';
import 'package:chat_app/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isLoading = false;


  String passs = "";
  String cpasss = "";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmcontroller = TextEditingController();
  double height = 0;
  double width = 0;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  //final currentuser=FirebaseAuth.instance.currentUser;
  Future saveUserData(String email, String password, String phone, String name,
      String confirm) {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) // Optionally, you can specify a document ID here
        .set({
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'confirm': confirm,
      'id':FirebaseAuth.instance.currentUser!.uid,

      // Add more fields as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                // SizedBox(
                //   // height: 40,
                //   height: height * 0.0446428571428571,
                // ),
                // Container(
                //   // height: 53,
                //   height: height * 0.0591517857142857,
                //   // width: 53,
                //   width: width * 0.1280193236714976,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       image: DecorationImage(
                //         image: AssetImage("assets/chatify.png"),
                //         fit: BoxFit.fill,
                //       )
                //   ),
                // ),

                SizedBox(
                  // height: 100,
                  height: height * 0.1116071428571429,
                ),

                /*StreamBuilder(
                  stream: FirebaseAuth.instance
                      .authStateChanges()
                      .where((user) => user != null),
                  builder: (context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.hasData) {
                      String uid = snapshot.data!.uid;
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('images')
                            .where('id', isEqualTo: uid)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting for data, display a loading indicator
                            return CircularProgressIndicator();
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.length != 0) {
                            // Render the image widget using the URL from Firestore
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {});
                                  _uploadImage();
                                },
                                child: Image.network(
                                    '${snapshot.data!.docs[0]['Image']}'),
                              ),
                            );
                          } else {
                            // Render a placeholder widget or text when no image is found
                            return Container(
                              child: Text("No image found"),
                            );
                          }
                        },
                      );
                    } else {
                      // Handle the case when the user is not authenticated
                      return Text('User not authenticated');
                    }
                  },
                ),

                // StreamBuilder(
                //     stream: FirebaseFirestore.instance.collection('images')
                //          .where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                //         //.where('id',isEqualTo: 'l4DMSz6rLVKaCi90bw8q')
                //         .snapshots(),
                //     builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                //       if(snapshot.hasData && snapshot.data!.docs.length!=0)
                //         {
                //           return
                //            Container(
                //              height: 100,
                //                width: 100,
                //                decoration: BoxDecoration(
                //                  shape: BoxShape.circle
                //                ),
                //                child: InkWell(
                //                    onTap: (){
                //                      setState(() {
                //
                //                      });
                //                      _uploadImage();
                //                    },
                //                    child: Image.network('${snapshot.data!.docs[0]['Image']}')));
                //          //    CircleAvatar(
                //          //    radius: 64,
                //          //
                //          //    // backgroundColor: Color(0xff697a69),
                //          //    child: InkWell(
                //          //      onTap: (){
                //          //        _uploadImage();
                //          //      },
                //          //      child: Center(
                //          //        child: Icon(Icons.edit),
                //          //      ),
                //          //    ),
                //          //    backgroundImage:
                //          //  );
                //         }
                //
                //   return Container(
                //
                //       child: InkWell(
                //           onTap: (){
                //             setState(() {
                //
                //             });
                //             _uploadImage();
                //           },
                //           child: Text("data")));
                // }),*/
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Color(0xff000000),
                      width: 3,
                    )
                  ),
                  child: Center(
                    child: Text("Sign Up",style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Arima',
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),),
                  ),
                ),

                SizedBox(
                  // height: 50,
                  height: height * 0.0558035714285714,
                ),
                MyTextField(
                  controller: _namecontroller,
                  hinttext: "Enter your name",
                  prefixicon: Icons.person_outline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter name";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  // height: 20,
                  height: height * 0.0223214285714286,
                ),

                MyTextField(
                  keytype: TextInputType.emailAddress,
                  hinttext: "Enter your email",
                  prefixicon: Icons.email_outlined,
                  controller: _emailcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your email";
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  // height: 20,
                  height: height * 0.0223214285714286,
                ),

                MyTextField(
                  keytype: TextInputType.number,
                  hinttext: "Enter your number",
                  prefixicon: Icons.phone_outlined,
                  controller: _numbercontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "number field is empty";
                    }else if(value.length != 11){
                      return "enter 11 digits number";
                    }

                    else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  // height: 20,
                  height: height * 0.0223214285714286,
                ),

                MyTextField(
                  obs: true,
                  hinttext: "Enter password",
                  prefixicon: Icons.lock_outline,
                  controller: _passwordcontroller,
                  onchange: (value) {
                    passs = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password field is empty";
                    } else if (value.length < 8) {
                      return "enter at least 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  // height: 20,
                  height: height * 0.0223214285714286,
                ),

                MyTextField(
                  obs: true,
                  hinttext: "Confirm password",
                  prefixicon: Icons.lock_outline,
                  controller: _confirmcontroller,
                  onchange: (value) {
                    cpasss = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password field is empty";
                    } else if (value.length < 8) {
                      return "enter at least 8 characters";
                    } else if (passs != cpasss) {
                      return "enter that password which you already put";
                    } else {
                      return null;
                    }
                  },
                ),

                SizedBox(
                  // height: 30,
                  height: height * 0.0334821428571429,
                ),

                InkWell(
                  onTap: () async {
                    if (formkey.currentState!.validate() && !isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                      String name = _namecontroller.text.trim();
                      String email = _emailcontroller.text.trim();
                      String number = _numbercontroller.text.trim();
                      String pass = _passwordcontroller.text.trim();
                      String cpass = _confirmcontroller.text.trim();

                      //     await FirebaseServices.signUp(name,email,number,pass,cpass);
                      // Navigator.pushNamed(context, OnLoadingTwo.id);
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: pass)
                          .then((value) {
                        if (value.user!.uid != "") {
                          saveUserData(email, pass, number, name, cpass)
                              .whenComplete(() {
                                print("signup complete");
                            Navigator.pushNamed(context, OnLoadingTwo.id);
                          });
                        }
                      });
                      setState(() {
                        isLoading = false; // Set isLoading to false after values are saved
                      });

                      // .then((_) => print('User data saved to Firestore'))
                      // .catchError((error) => print('Error saving user data: $error'));

                      // Navigator.pushNamed(context, OnLoadingTwo.id);
                    }
                  },
                  child: Container(
                    // height: 60,
                    height: height * 0.0669642857142857,
                    //height: height * 0.0714285714285714,
                    //  width: 130,
                    width: width * 0.3140096618357488,
                    //width: width * 0.4347826086956522,
                    decoration: BoxDecoration(
                      color: Color(0xffACDDDE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: isLoading // Show different content based on the loading state
                        ? LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      backgroundColor: Colors.grey[300],
                    ) // Show loading indicator
                        :
                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  // height: 10,
                  height: height * 0.0111607142857143,
                ),

                Container(
                  // height: 29,
                  // width: 374,
                  height: height * 0.0323660714285714,
                  width: width * 0.9033816425120773,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            // fontSize: 18,
                            fontSize: (height * 0.0200892857142857 / 2 +
                                width * 0.0434782608695652 / 2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            // color: Color(0xff7E7E7E),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, OnLoadingTwo.id);
                          },
                          child: Text(
                            "  Log in.",
                            style: TextStyle(
                              // fontSize: 18,
                              fontSize: (height * 0.0200892857142857 / 2 +
                                  width * 0.0434782608695652 / 2),
                              fontWeight: FontWeight.w500,
                              color: Color(0xff008080),
                            ),
                          ),
                        ),

                        // TextButton(onPressed: (){
                        //   Navigator.pushNamed(context, OnLoadingOne.id);
                        // }, child: Text("Log in",style: TextStyle(
                        //   fontWeight: FontWeight.w500,
                        //   // fontSize: 18,
                        //     fontSize: (height *0.0200892857142857/2 + width * 0.0434782608695652/2),
                        //   color: Color(0xff008080),
                        // ),)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
