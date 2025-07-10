import 'package:bellefu/onboarding.dart';
import 'package:bellefu/pages/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BellefuApp extends StatefulWidget {
  BellefuApp({Key? key}) : super(key: key);

  @override
  State<BellefuApp> createState() => _BellefuAppState();
}

class _BellefuAppState extends State<BellefuApp> {
  bool regDirection = false;

  bool isReady = false;

  _checkRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int notfirsttime = prefs.getInt('registered') ?? 0;
    setState(() {
      regDirection = notfirsttime == 1;
      isReady = true;
    });
  }

  @override
  void initState() {
    _checkRegistrationStatus();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.onTokenRefresh.listen((String fcmToken) {
      // send token to server
    });
    FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.subscribeToTopic("bellefu_Radio");

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // final routeFromMessage = message.data["route"];
        final String routeFromMessage = message.data['key'];
        // Navigator.of(context).pushNamed(routeFromMessage);
        print(routeFromMessage);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "bellefuradio_notification",
              "Bellefu Radio Online",
              channelDescription: "",
              // ztodo add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'notification',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Printing on Message Notification click");
      message.data.keys.forEach((element) {
        print("Printing on Message Notification click keys $element");
      });
      if (message != null) {
        if (message.data.isNotEmpty) {
          String course_id = message.data['course_id'] as String;
          String type = message.data['type'] as String;
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const DashBoard(),
            ),
            (route) => false);
      }
    });

    return MaterialApp(
      title: 'Bellefu Radio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isReady
          ? regDirection
              ? const DashBoard()
              : OnBoardingPages()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/welcome.png'),
                  fit: BoxFit.cover,
                  scale: 1.0,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      debugShowCheckedModeBanner: false,
    );
  }
}
