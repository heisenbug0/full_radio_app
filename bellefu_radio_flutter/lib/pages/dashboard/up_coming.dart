import 'dart:async';
import 'dart:convert';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:bellefu/common/Constants.dart';
import 'package:bellefu/models/UpComingTable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bellefu/common/advert_bar.dart';
import 'package:bellefu/common/my_app_bar.dart';
import 'package:intl/intl.dart';

class UpComing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(title: 'Bellefu Radio'),
        AdvertBar(),
        SizedBox(
          height: 4.0,
        ),
        UpcomingListView(),
      ],
    );
  }
}

class UpcomingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UpComingTable>>(
      future: _fetchUpcoming(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UpComingTable>? data = snapshot.data;
          return Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchUpcoming,
              child: _upComingListView(data),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<UpComingTable>> _fetchUpcoming() async {
    final response = await http.get(
      Uri.parse(Constants.UPCOMING_URL),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new UpComingTable.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load up coming events');
    }
  }

  ListView _upComingListView(data) {
    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: 5.0,
      ),
      separatorBuilder: (context, index) => Divider(
        height: 3.0,
        color: Colors.black12,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: 0.5),
        child: upComingCard(data[index], context, index),
      ),
    );
  }

  Widget upComingCard(UpComingTable videosItem, BuildContext context, int index) {
    return SizedBox(
      height: 96.0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.only(left: 2.0, right: 3.0, top: 2.0, bottom: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFC4C4C4).withOpacity(index % 2 == 1 ? 0.21 : 0.51),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 3.0,
            ),
            Container(
              width: 94.0,
              height: 82.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(5.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(videosItem.image_url),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    videosItem.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF01012A).withOpacity(0.8),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2.5,
                  ),
                  SizedBox(
                    width: 200.0,
                    child: Text(
                      videosItem.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: const Color(0xFF01012A),
                      ),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          DateFormat('hh:mm a').format(DateTime.parse(videosItem.scheduled_for)),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color(0xFF01012A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {
                  addToCalendar(videosItem);
                },
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Image.asset(
                    'assets/group.png',
                    width: 25.0,
                    height: 25.0,
                    fit: BoxFit.cover,
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

void addToCalendar(UpComingTable videosItem) {
  final Event event = Event(
    title: 'Bellefu Radio - ${videosItem.title}',
    description: '${videosItem.description}',
    location: 'Bellefu Radio',
    startDate: DateTime.parse(videosItem.scheduled_for),
    endDate: DateTime.parse(videosItem.scheduled_to),
    iosParams: IOSParams(
      reminder: Duration(minutes: 5, hours: 1), // on iOS, you can set alarm notification after your event.
    ),
    androidParams: AndroidParams(
      emailInvites: [], // on Android, you can add invite emails to your event.
    ),
  );
  Add2Calendar.addEvent2Cal(event);
}
