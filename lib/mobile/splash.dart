import 'package:flutter/material.dart';
import 'package:samplec/mobile/secondScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecondScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.white,body: Center(child: SizedBox(width:150,height:90,child: Image.asset("assets/images/logo.png")))) ;
  }
}
