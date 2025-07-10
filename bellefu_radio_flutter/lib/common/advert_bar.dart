import 'dart:async';
import 'dart:convert';

import 'package:bellefu/common/Constants.dart';
import 'package:bellefu/models/advert%20_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AdvertBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowAdverts();
  }
}

class ShowAdverts extends StatefulWidget {
  const ShowAdverts({Key? key}) : super(key: key);

  @override
  _ShowAdvertsState createState() => _ShowAdvertsState();
}

class _ShowAdvertsState extends State<ShowAdverts> {
  late List<AdvertModel> _adverts;
  late List<dynamic> webimageSliders = [NetworkImage('https://radio.bellefu.online/storage/Slide 12.jpg')];
  bool _isReady = false;

  Future _fetchAdverts() async {
    final response = await http.get(
      Uri.parse(Constants.ADVERTS_URL),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _adverts = jsonResponse.map((job) => new AdvertModel.fromJson(job)).toList();

      setState(() {
        webimageSliders = _adverts
            .map(
              (item) => _advertPanel(item),
            )
            .toList();
        _isReady = true;
      });
    } else {
      throw Exception('Failed to load adverts');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAdverts();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115.0,
      width: MediaQuery.of(context).size.width * 0.9578, //  300.0,
      child: _isReady
          ? Carousel(
              borderRadius: true,
              showIndicator: false,
              radius: Radius.circular(11.0),
              images: webimageSliders,
              defaultImage: NetworkImage('https://radio.bellefu.online/storage/Slide 12.jpg'),
              animationDuration: const Duration(milliseconds: 500),
              autoplayDuration: const Duration(seconds: 5),
              onImageTap: (value) {
                print(value);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _advertPanel(AdvertModel item) {
    return InkWell(
      onTap: () async {
        if (!await launch(item.link_url)) throw 'Could not launch ${item.link_url}';
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                Constants.SERVER_STORAGE_URL + '/adverts/' + item.image_url,
                scale: 1.0,
              ),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
    );
  }
}
