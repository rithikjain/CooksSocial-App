import 'package:cooks_social/pages/landing/landing_page.dart';
import 'package:cooks_social/pages/mainapp/home_page.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFC6C6C),
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cooks Social",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Montserrat",
        primaryColor: Color(0xFF2081C3),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: FutureBuilder<String>(
        future: SharedPref.getUserAuthToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
