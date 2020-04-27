import 'package:cooks_social/pages/landing/landing_page_1.dart';
import 'package:cooks_social/pages/landing/landing_page_2.dart';
import 'package:cooks_social/pages/signup/phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> pages = [LandingPage1(), LandingPage2(), PhoneNumberPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
        itemCount: pages.length,
        loop: false,
        scrollDirection: Axis.horizontal,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.black,
            activeColor: Colors.black,
            size: 5,
            activeSize: 10,
          ),
        ),
      ),
    );
  }
}
