import 'package:bellefu/data/DataProvider.dart';
import 'package:bellefu/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage3 extends StatelessWidget {
  const WelcomePage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _devHeight = MediaQuery.of(context).size.height;
    final double _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: _devWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome3.png'),
            fit: BoxFit.cover,
            // filterQuality: FilterQuality.high,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: _devHeight * 0.40724137,
                left: _devWidth * 0.0777333,
              ),
              child: Text(
                "Tune in for Farming tips and News",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 25.0,
                left: 40.0,
                right: 40.0,
              ),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(60),
                    onTap: () async {
                      await Provider.of<DataProvider>(context, listen: false).SignInRegistered();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 310.0,
                        minHeight: 58.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffffb700),
                      ),
                      child: Center(
                        child: Text(
                          "START LISTENING",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      "By continuing, you agree to our Terms of Service & Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff81868c),
                        fontSize: 13.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    width: 135.0,
                    height: 5.0,
                    margin: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
