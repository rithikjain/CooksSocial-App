import 'package:cooks_social/pages/landing/landing_page_1.dart';
import 'package:cooks_social/pages/landing/landing_page_2.dart';
import 'package:cooks_social/pages/signup/phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFC6C6C),
                      ),
                      child: SvgPicture.asset(
                        "assets/images/bg.svg",
                        fit: BoxFit.fill,
                        color: Color(0xFFDB162F),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      transform: Matrix4.translationValues(0, -20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Swiper(
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
            ),
          ],
        ),
      ),
    );
  }
}
