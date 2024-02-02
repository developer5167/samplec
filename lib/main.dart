import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samplec/mobile/secondScreen.dart';
import 'firebase_options.dart';
import 'mobile/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform,);
  if (kDebugMode) {
    try {
      FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
      FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
    } catch (e) {
      print(e);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(color: Colors.white70,);
  }
}
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late StreamSubscription<DocumentSnapshot> subscription;
//   DocumentReference documentReference = FirebaseFirestore.instance.collection('sample').doc('ckdjc');
//
//   @override
//   void initState() {
//     super.initState();
//     // Start listening to document events
//     subscription = documentReference.snapshots().listen((snapshot) {
//       if (snapshot.exists) {
//         var data = snapshot.data();
//         print('Document Data: $data');
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
//         stopListening();
//         // Update UI or perform other actions based on the document events
//       } else {
//         print('Document does not exist');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Firestore Document Listener'),
//         ),
//         body: Center(child: Container()));
//   }
//
//   void stopListening() async {
//     await subscription.cancel();
//     print('Stopped Listening to Firestore Events');
//   }
//
//   @override
//   void dispose() {
//     // Cancel the subscription when the widget is disposed
//     print('Stopped Listening to Firestore Events');
//
//     subscription.cancel();
//     super.dispose();
//   }
// }
