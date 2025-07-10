import 'package:bellefu/pages/onboarding/page1.dart';
import 'package:bellefu/pages/onboarding/page2.dart';
import 'package:bellefu/pages/onboarding/page3.dart';
import 'package:flutter/material.dart';

class OnBoardingPages extends StatefulWidget {
  const OnBoardingPages({Key? key, this.pageIndex = 0}) : super(key: key);

  final int pageIndex;

  @override
  State<OnBoardingPages> createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {
  int _currentPage = 0;
  late PageController controller;

  final List<Widget> _pageOnBoard = const [
    WelcomePage1(),
    WelcomePage2(),
    WelcomePage3(),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: widget.pageIndex);
    _currentPage = widget.pageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: _pageOnBoard,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }
}
