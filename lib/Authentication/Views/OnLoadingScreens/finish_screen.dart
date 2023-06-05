import 'package:chat_app/Authentication/Views/Home%20Screens/home_screen_one.dart';
import 'package:flutter/material.dart';
class FinishScreen extends StatefulWidget {
  static const String id = "finish_screen";
  const FinishScreen({Key? key}) : super(key: key);

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffCAF1DE),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              // height: 163,
              height: height * 0.1819196428571429,
            ),
            Container(
              // height: 228,
              height: height * 0.2544642857142857,
              // width: 274.21,
              width: width * 0.6623429951690821,
              child: Image.asset("assets/success.png",fit: BoxFit.fill,),
            ),
            SizedBox(
              // height: 105,
              height: height * 0.1171875,
            ),
            InkWell(
              onTap: (){
                  //Navigator.pushNamed(context, HomeScreenOne.id);
                  },
                  child: Container(
                    // height: 64,
                    height: height * 0.0714285714285714,
                    // width: 180,
                    width: width * 0.4347826086956522,
                    decoration: BoxDecoration(
                      color: Color(0xffACDDDE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text("FINISH",style: TextStyle(
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
    );
  }
}
