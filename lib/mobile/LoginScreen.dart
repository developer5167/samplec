import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:samplec/SharedPref.dart';
import 'package:samplec/mobile/homeScreen.dart';
import 'package:samplec/mobile/question_page_one.dart';
import 'package:samplec/mobile/question_page_two.dart';
import 'package:samplec/mobile/verifyOtp.dart';
import 'package:samplec/network/genericRepository.dart';

import 'model/MyData.dart';
import '../colors.dart';
import '../constants.dart';
import '../styles.dart';
import 'model/OtpResponse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MyData myData = MyData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "If you could kindly provide us with your mobile number, it will allow us to ensure that we can reach you promptly and efficiently when necessary",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Note: OTP Not Required",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getVerticalField(
                          onTap: () {},
                          onChanged: (value) {
                            myData.mobileNumber = value;
                          },
                          editTextHint: "Mobile Number*",
                          inputField: TextInputType.phone)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      //check weather account exists or not, if account doesn't exist send to OTP screen and then start asking questions, else directly open home screen
                      if (myData.checkLoginScreenStatus()) {
                        checkUserInDB();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const VerifyOtp()));
                      } else {
                        Constants.showSnackBar(context, "Field's can't be empty");
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: pinkColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Verify",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkUserInDB() async {
    myData.id = "chatSpotUserID_${myData.mobileNumber}";
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuestionPageOne()));
    // GenericRepo genericRepo = GenericRepo();
    // SharedPref sharedPref = SharedPref();
    // if (!await Constants.checkNetWorkConnection()) {
    //   if (!mounted) return;
    //   Constants.showSnackBar(context, "Check internet Connection and try again");
    //   return;
    // }
    // print('>>>>>>>   ${myData.mobileNumber}');
    //
    // try {
    //   Response? loginResponse = await genericRepo.checkUser(myData.mobileNumber.toString());
    //   if (!mounted) return;
    //   if (loginResponse!.statusCode == 200) {
    //     MyData loginResponseData = MyData.fromJson(json.decode(loginResponse.body));
    //     sharedPref.save("user", loginResponseData);
    //     if (loginResponseData.gender == "" && loginResponseData.email == "" && loginResponseData.interestedIn == "") {
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuestionPageOne()));
    //     } else if (loginResponseData.name == "") {
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuestionPageTwo()));
    //     } else {
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(loginResponseData: loginResponseData)));
    //     }
    //   } else {
    //     sendOtp();
    //   }
    // } catch (e) {
    //   if (!mounted) return;
    //   Constants.showSnackBar(context, "No internet available,please check your able to open google.com");
    // }
  }

  // void sendOtp() async {
  //   GenericRepo genericRepo = GenericRepo();
  //   if (!await Constants.checkNetWorkConnection()) {
  //     if (!mounted) return;
  //     Constants.showSnackBar(context, "Check internet Connection and try again");
  //     return;
  //   }
  //   try {
  //     Response? response = await genericRepo.sendOtp(myData);
  //     if (!mounted) return;
  //     if (response!.statusCode == 200) {
  //       OtpResponse otpResponse = OtpResponse.fromJson(json.decode(response.body));
  //       Constants.showSnackBar(context, otpResponse.message![0]);
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VerifyOtp()));
  //     } else {
  //       Constants.showSnackBar(context, response.body);
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     Constants.showSnackBar(context, "Error sending OTP");
  //   }
  // }
}
