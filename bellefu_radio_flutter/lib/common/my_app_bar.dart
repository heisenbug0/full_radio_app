import 'package:bellefu/pages/playradio.dart';
import 'package:bellefu/pages/view_web_url.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  MyAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PlayRadio()),
                  );
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
                  widget.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: const Color(0xFF0A0A36),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: PopupMenuButton<int>(
                  color: Colors.white,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.contact_phone_outlined,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Contact Us")
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("About Us")
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.network_cell,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Links")
                        ],
                      ),
                    ),
                  ],
                  onSelected: (item) => _selectedItem(context, item),
                ),
                /*SizedBox(
                  width: 65.0,
                  height: 70.0,
                  child: Image.asset(
                    'assets/user_profile.png',
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
            ],
          ),
          /*Row(
            children: [
              Text(
                widget.title ?? 'air',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }

  _selectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewWebUrl(
              weburl: 1,
            ),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewWebUrl(
              weburl: 2,
            ),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewWebUrl(
              weburl: 3,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }
}
