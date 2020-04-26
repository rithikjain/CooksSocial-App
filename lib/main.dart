import 'package:cooks_social/pages/signup/enter_phone_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cooks Social",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Open Sans",
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: EnterPhone(),
    );
  }
}
