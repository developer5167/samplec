import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplec/mobile/question_page_one.dart';

import '../colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hey",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(color: pinkColor, fontSize: 36, fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextSpan(
                      text: ",",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: blackColor,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "Help us knowing ",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: blackColor,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "more ",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: blackColor,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "about you",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: blackColor,
                          fontSize: 36,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const QuestionPageOne()));
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
                      "OKAY",
                      style: TextStyle(color: whiteColor, fontWeight: FontWeight.w800, fontSize: 20),
                    ),
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
