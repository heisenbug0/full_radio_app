import 'package:bellefu/onboarding.dart';
import 'package:flutter/material.dart';

class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _devHeight = MediaQuery.of(context).size.height;
    final double _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: _devWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome.png'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: _devHeight * 0.28817733,
                left: _devWidth * 0.0777333,
              ),
              child: Text(
                "Agric\nOnline Radio",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 43,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: _devWidth * 0.127733,
                top: 15.0,
              ),
              width: _devWidth * 0.65,
              height: 82.0,
              child: Text(
                "Enjoy the best farmers exclusive radio broadcast from anywhere! Don't miss out on anything",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => OnBoardingPages(pageIndex: 1),
                  ),
                );
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 310.0,
                  minHeight: 58.0,
                ),
                margin: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 50.0,
                  left: 40.0,
                  right: 40.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffffb700),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "NEXT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "Open Sans",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ],
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
