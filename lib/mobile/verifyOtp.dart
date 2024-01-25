import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplec/mobile/homeScreen.dart';
import 'package:samplec/mobile/question_page_one.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../colors.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();

      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                "assets/images/back.png",
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(),
               Column(
                 children: [
                   RichText(
                     textAlign: TextAlign.center,
                     text: TextSpan(
                       children: [

                         TextSpan(
                           text: "Hurry!",
                           style: GoogleFonts.poppins(
                             textStyle: const TextStyle(color: pinkColor, fontSize: 36, fontWeight: FontWeight.w800),
                           ),
                         ),

                         TextSpan(
                           text: "\nalmost done",
                           style: GoogleFonts.poppins(
                             textStyle: const TextStyle(
                               color: blackColor,
                               fontWeight: FontWeight.w800,
                               fontSize: 36,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(

                       "please enter the otp\nsent to registered mobile number",
                       style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor),fontSize: 12,fontWeight: FontWeight.w400),
                       textAlign: TextAlign.center,
                     ),
                   ),
                   const SizedBox(height: 20,),
                   PinCodeTextField(

                     appContext: context,
                     pastedTextStyle: const TextStyle(
                       color: pinkColor,
                       fontWeight: FontWeight.w800,
                     ),
                     length: 4,
                     obscureText: true,

                     blinkWhenObscuring: true,
                     animationType: AnimationType.fade,
                     validator: (v) {
                       return null;
                       // if (v!.length < 3) {
                       //   return "I'm from validator";
                       // } else {
                       //   return null;
                       // }
                     },
                     pinTheme: PinTheme(
                       fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 20),
                       borderRadius: BorderRadius.circular(5),
                       shape: PinCodeFieldShape.box,
                       borderWidth: 5,

                       inactiveBorderWidth: 2,
                       activeBorderWidth: 3,
                       fieldHeight: 50,
                       fieldWidth: 50,
                       selectedBorderWidth: 5,
                       selectedColor: blackColor,
                       disabledColor: pinkColor,
                       inactiveColor: pinkColor,
                       selectedFillColor: pinkColor,
                       activeColor: pinkColor,
                       activeFillColor: Colors.transparent,
                     ),
                     cursorColor: Colors.black,
                     cursorWidth: 3,

                     animationDuration: const Duration(milliseconds: 300),
                     enableActiveFill: false,
                     errorAnimationController: errorController,
                     controller: textEditingController,
                     keyboardType: TextInputType.number,
                     boxShadows: const [
                       BoxShadow(
                         offset: Offset(0, 1),
                         color: Colors.black12,
                         blurRadius: 10,
                       )
                     ],
                     onCompleted: (v) {
                       debugPrint("Completed");
                     },
                     // onTap: () {
                     //   print("Pressed");
                     // },
                     onChanged: (value) {
                       debugPrint(value);
                       setState(() {
                         currentText = value;
                       });
                     },
                     beforeTextPaste: (text) {
                       debugPrint("Allowing to paste $text");
                       //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                       //but you can show anything you want here, like your pop up saying wrong paste format or etc
                       return true;
                     },
                   ),
                 ],
               ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: pinkColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "FINISH",
                        style: TextStyle(color: whiteColor, fontWeight: FontWeight.w800, fontSize: 20),
                      ),
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
