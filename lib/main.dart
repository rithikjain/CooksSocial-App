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
        primaryColor: Color(0xFF1D6CE2),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
      ),
    );
  }
}
