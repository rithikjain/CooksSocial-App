import 'package:cooks_social/widgets/home_page_empty.dart';
import 'package:cooks_social/widgets/home_page_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset("assets/images/logo.svg"),
            Icon(Icons.star_border, color: Colors.black),
          ],
        ),
      ),
      body: Center(
        child: HomePageFeed(),
      ),
    );
  }
}
