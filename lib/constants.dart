import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(content,style: GoogleFonts.poppins(),),
        duration: const Duration(seconds: 2),
      ));
  }
  static Future<bool> checkNetWorkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }
}
// const BASE_URL = "https://us-central1-chatspotmain.cloudfunctions.net/";
const BASE_URL ="http://10.0.2.2:5001/chatspotmain/us-central1/"; /*mapped point = 10.0.2.2*/
