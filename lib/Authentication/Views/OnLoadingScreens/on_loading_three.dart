import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Home Screens/home_screen_one.dart';
import 'login.dart';

class OtpScreen extends StatefulWidget {
  static const String id = "on_loading_three";
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _otp = '';
    double height = 0;
    double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                 height: 200,
                //height: height * 0.3828125,
                //height: height * 0.3828125,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: 65,
                      height: height * 0.0725446428571429,
                      // width: 65,
                      width: width * 0.1570048309178744,
                      child: Container(
                        color: Color(0xffF5F5f5),
                        child: TextFormField(
                          cursorColor: Color(0xffFF2156),
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 65,
                      height: height * 0.0725446428571429,
                      // width: 65,
                      width: width * 0.1570048309178744,
                      child: Container(
                        color: Color(0xffF5F5f5),
                        child: TextFormField(
                          cursorColor: Color(0xffFF2156),
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 65,
                      height: height * 0.0725446428571429,
                      // width: 65,
                      width: width * 0.1570048309178744,
                      child: Container(
                        color: Color(0xffF5F5f5),
                        child: TextFormField(
                          cursorColor: Color(0xffFF2156),
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 65,
                      height: height * 0.0725446428571429,
                      // width: 65,
                      width: width * 0.1570048309178744,
                      child: Container(
                        color: Color(0xffF5F5f5),
                        child: TextFormField(
                          cursorColor: Color(0xffFF2156),
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).hasFocus;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: 45,
                height: height * 0.0502232142857143,
              ),
              Padding(
                padding:  EdgeInsets.only(left: 157, right: 20),
                child: Container(
                  // height: 29,
                  height: height * 0.0323660714285714,
                  // width: 237,
                  width: width * 0.572463768115942,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Resend Code 49 Sec",style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff000011)
                      ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                 height: 300,
                //height: height * 0.0178571428571429,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, HomeScreen.id);
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
            ],
          ),
        ),
      ),
    );
  }
}