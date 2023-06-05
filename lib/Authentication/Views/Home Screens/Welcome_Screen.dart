import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/Authentication/Views/Home%20Screens/home_screen_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushNamed(context, HomeScreen.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs;
           // String? name = snapshot.data?.get('name') as String?;
            if (docs[0]['name'] != null) {
              return Container(
                height: s.height,
                width: s.width,
               // color: Color(0xffd78e8e),
                child: Center(
                  child: SizedBox(
                    width: 250.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 50.0,
                       fontFamily: 'Arima',
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w600,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ScaleAnimatedText('Welcome'),
                          ScaleAnimatedText('${docs[0]['name']}'),
                          ScaleAnimatedText('To Chatify'),
                          ScaleAnimatedText("Let's Go ->"),

                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                ),
                // child: Text(
                //   'Welcome ${docs[0]['name']}',
                //   style: TextStyle(
                //     fontSize: 50,
                //   ),
                // ),
              );
            } else {
              return Text('Name not found');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Loading...');
          }
        },
      ),
    );
  }
}


