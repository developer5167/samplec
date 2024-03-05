import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          showCloseIcon: true,
          dismissDirection: DismissDirection.up,
          behavior: SnackBarBehavior.fixed,
          content: Text(
            content,
            style: GoogleFonts.poppins(),
          ),
        ),
      );
  }

  static Future<bool> checkNetWorkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }


}

// const BASE_URL = "https://us-central1-chatspotmain.cloudfunctions.net/";
const BASE_URL ="http://10.0.2.2:5001/chatspotmain/us-central1/"; /*mapped point = 10.0.2.2*/

// android
// AdMob app ID ca-app-pub-3940256099942544~3347511713
const ANDROID_BANNER ='ca-app-pub-3940256099942544/6300978111';
const ANDROID_INTERSTITIAL=  'ca-app-pub-3940256099942544/1033173712';
const ANDROID_REWARDED= 'ca-app-pub-3940256099942544/5224354917';

// ios
// Admob id ca-app-pub-3940256099942544~1458002511
const IOS_BANNER ='ca-app-pub-3940256099942544/2934735716';
const IOS_INTERSTITIAL= 'ca-app-pub-3940256099942544/4411468910';
const IOS_REWARDED= 'ca-app-pub-3940256099942544/1712485313';










