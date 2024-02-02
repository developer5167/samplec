import 'package:flutter/material.dart';
import 'package:samplec/mobile/secondScreen.dart';

import '../MyData.dart';
import '../SharedPref.dart';
import '../constants.dart';
import 'LoginScreen.dart';
import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      loadSharedPrefs();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.white,body: Center(child: SizedBox(width:150,height:90,child: Image.asset("assets/images/logo.png")))) ;
  }
  loadSharedPrefs() async {
    var sharedPref = SharedPref();
    try {
      MyData user = MyData.fromJson(await sharedPref.read("user"));
      if (user.id == "") {
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } catch (e) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      Constants.showSnackBar(context, "some thing went wrong");
    }
  }
}
