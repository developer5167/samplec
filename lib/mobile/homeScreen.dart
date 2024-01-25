import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplec/mobile/question_page_two.dart';

import '../colors.dart';
import '../styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Column(children: [
                 RichText(
                   textAlign: TextAlign.center,
                   text: TextSpan(
                     children: [

                       TextSpan(
                         text: "Welcome! ",
                         style: GoogleFonts.poppins(
                           textStyle: const TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w800),
                         ),
                       ),

                       TextSpan(
                         text: "Samuel",
                         style: GoogleFonts.poppins(
                           textStyle: const TextStyle(
                             color: pinkColor,
                             fontWeight: FontWeight.w800,
                             fontSize: 20,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 Align(
                   alignment: Alignment.center,
                   child: Text(
                     "we are very happy to see you here, please hold on we are connecting you to a random user",
                     style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor),fontSize: 12,fontWeight: FontWeight.w300),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ],),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Note:\nPlease remember to engage respectfully and be mindful of privacy boundaries when chatting. Report any inappropriate behaviour, and review our Terms of Service for guidance.",
                    style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor),fontSize: 12,fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
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
