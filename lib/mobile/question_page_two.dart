import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplec/constants.dart';
import 'package:samplec/mobile/homeScreen.dart';
import 'package:samplec/network/genericRepository.dart';

import 'model/MyData.dart';
import '../SharedPref.dart';
import '../colors.dart';
import '../styles.dart';

class QuestionPageTwo extends StatefulWidget {
  const QuestionPageTwo({super.key});

  @override
  State<QuestionPageTwo> createState() => _QuestionPageTwoState();
}

class _QuestionPageTwoState extends State<QuestionPageTwo> {
  @override
  Widget build(BuildContext context) {
    MyData myData = MyData();

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
                          "We kindly ask you to provide your name as you would prefer it to appear in our records",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Note: Please rest assured that your contact information will be handled with the utmost confidentiality and will only be used for the intended purpose.",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getVerticalField(
                          onTap: () {},
                          onChanged: (value) {
                            myData.name = value;
                          },
                          editTextHint: "Name*",
                          inputField: TextInputType.name)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "If you have a preferred nickname that you would like us to use in our correspondence, please feel free to share it at your convenience",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Note: please rest assured that any details you share will be treated with the utmost confidentiality.",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getVerticalField(
                          onTap: () {},
                          onChanged: (value) {
                            myData.nickName = value;
                          },
                          editTextHint: "Nick Name(optional)",
                          inputField: TextInputType.name)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (myData.checkSecondPageStatus()) {
                        print('>>>>>>>');

                        pushDataToDB(myData, context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      } else {
                        Constants.showSnackBar(context, "Field's can't be empty");
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: pinkColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "Submit",
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

  void pushDataToDB(MyData myData, BuildContext context) async {
    SharedPref sharedPref = SharedPref();
    try {
      sharedPref.save("user", myData);
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()));
    } catch (e) {
      print(e);
    }
  }
}
