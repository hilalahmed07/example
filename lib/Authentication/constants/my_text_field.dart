import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hinttext;
  final IconData prefixicon;
  final IconData? suffixicon;
  final bool obs;
  String? Function(String?)? validator;
  void Function(String)? onchange;
   TextInputType? keytype;

  TextEditingController  controller;

   MyTextField({
     this.obs = false,
     this.keytype,
     this.onchange,
     required this.controller,
     this.validator,
    required this.hinttext,
    required this.prefixicon,
    this.suffixicon,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: 65,
      height: height * 0.0725446428571429,
      // width: 340,
      width: width * 0.821256038647343,
      decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obs,
          keyboardType: keytype,
          controller: controller,
          validator: validator,
          onChanged: onchange,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Padding(
                padding:  EdgeInsets.only(left: 20),
                child: Icon(prefixicon,color: Color(0xff008080),size: 30,),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 40),
              prefix: SizedBox(
                width: 43,
              ),
              suffixIcon: suffixicon != null ? Icon(suffixicon) : null,
              // contentPadding: EdgeInsets.symmetric(horizontal: 16),
              //border: OutlineInputBorder(),
              hintText: hinttext,
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                // color: Color(0xff272A2F),
                color: Color(0xff008080),
              )
          ),
        ),
      ),
    );
  }
}
