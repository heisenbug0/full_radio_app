import 'dart:async';
import 'dart:io';

import 'package:bellefu/common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewWebUrl extends StatefulWidget {
  const ViewWebUrl({Key? key, required this.weburl}) : super(key: key);

  final int weburl;

  @override
  ViewWebUrlState createState() => ViewWebUrlState();
}

class ViewWebUrlState extends State<ViewWebUrl> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  double lineProgress = 0;
  String _webUrl = Constants.CONTACT_US_URL;
  String _pageTitle = 'Contact Us';
  // WebViewController _controller;

  @override
  void initState() {
    super.initState();
    switch (widget.weburl) {
      case 1:
        _webUrl = Constants.CONTACT_US_URL;
        _pageTitle = 'Contact Us';
        break;
      case 2:
        _webUrl = Constants.ABOUT_US_URL;
        _pageTitle = 'About Us';
        break;
      case 3:
        _webUrl = Constants.LINKS_URL;
        _pageTitle = 'Best Agro Links';
        break;
      default:
    }
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFFF6),
        body: Column(
          children: [
            pageTitleBar(),
            Expanded(
              child: _viewMyPage(),
            ),
          ],
        ),
        persistentFooterButtons: [
          _progressBar(lineProgress, context),
        ],
      ),
    );
  }

  Widget _viewMyPage() {
    return WebView(
      gestureNavigationEnabled: true,
      initialUrl: _webUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        // _controller = webViewController;
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        // print("WebView is loading (progress : $progress%)");
        setState(() {
          lineProgress = progress.toDouble();
        });
      },
      /*javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },*/
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          // print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        // print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        // print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        // print('Page finished loading: $url');
      },
    );
  }

  Widget _progressBar(double progress, BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget pageTitleBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 3.5,
        left: 5.0,
        right: 1.0,
        bottom: 10.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  /*Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PlayRadio()),
                  );*/
                },
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: Image.asset(
                    'assets/to_radio.png',
                    width: 30.0,
                    height: 30.0,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 13.0,
              ),
              Expanded(
                child: Text(
                  _pageTitle,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: const Color(0xFF0A0A36),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      size: 25.0,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
