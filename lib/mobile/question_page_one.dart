import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplec/MyData.dart';
import 'package:samplec/constants.dart';
import 'package:samplec/mobile/question_page_two.dart';

import '../colors.dart';
import '../styles.dart';

class QuestionPageOne extends StatelessWidget {
  const QuestionPageOne({super.key});

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
                  Text(
                    "I would appreciate it if you could provide me with the following information:",
                    style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "1.Could you please specify your gender for our records?",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 17),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Note:helps in maintaining personal preferences and matching algorithms",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getDropDownTextField((value) {
                        myData.gender = value;
                      }),
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
                          "2.If you are comfortable sharing your email address, kindly provide it at your earliest convenience",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 17),
                        ),
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
                      getVerticalField(onTap: () {}, onChanged: (value) {
                        myData.email = value;
                      }, editTextHint: "email ", inputField: TextInputType.emailAddress)
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
                          "3.Interested-in?",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 17),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Note:helps in maintaining personal preferences and matching algorithms",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getDropDownTextField2((value) {
                        myData.interestedIn = value;
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (myData.checkFirstPageStatus()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionPageTwo()));
                      } else {
                        Constants.showSnackBar(context, "Field's can't be empty");
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: pinkColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          "NEXT",
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
}
