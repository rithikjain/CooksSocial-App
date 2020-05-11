import 'package:flutter/material.dart';

class HomePageEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/chef3.png"),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Welcome Chef",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xB2030301),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            "We're more than happy to have you\non board with us.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xB2030301),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 32, bottom: 16, left: 8, right: 8),
          child: Text(
            "To get started",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xB2030301),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            "Follow some cooks by searching in the explore section so that your feed doesn’t remain so emp-tea ;)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xB2030301),
            ),
          ),
        ),
      ],
    );
  }
}
