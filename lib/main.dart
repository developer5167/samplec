import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'colors.dart';
import 'mobile/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  MobileAds.instance.initialize();
  print('initialised.......');
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: [
/* These are `IDs` of different mobile phones on which I have installed and tested my app.  */

        '568858D3910384AA29D4896CBE3627CE',
        // "85BB5D148620523D06692E2F45ED4A30",
        // "2F4C6DEC28A5611835CA2C3EE14EF31C",
      ],
    ),
  );
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

  ThemeData _buildLightTheme() {
    return ThemeData(
      textTheme: _buildTextTheme(Brightness.light),
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      // Define other light theme properties here
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      textTheme: _buildTextTheme(Brightness.light),

      brightness: Brightness.dark,
      primarySwatch: Colors.pink,
      // Define other dark theme properties here
    );
  }

  TextTheme _buildTextTheme(Brightness brightness) {
    return brightness == Brightness.light
        ? ThemeData.light().textTheme.copyWith(
              headlineMedium: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
        // Define your light mode text styles here
        // Add more text styles as needed,
        : ThemeData.dark().textTheme.copyWith(
            // Define your dark mode text styles here
            // Add more text styles as needed
            );
  }
}
