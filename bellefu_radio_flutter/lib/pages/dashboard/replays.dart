import 'dart:async';
import 'dart:convert';

import 'package:bellefu/models/UpComingTable.dart';
import 'package:bellefu/pages/dashboard/replay_audio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bellefu/common/my_app_bar.dart';

const String REPLAY_URL = 'https://radio.bellefu.online/api/replays';
const String SERVER_STORAGE_URL = 'https://radio.bellefu.online/storage/';

class Replays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(title: 'Replay'),
        SizedBox(
          height: 4.0,
        ),
        ReplaysListView(),
      ],
    );
  }
}

class ReplaysListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UpComingTable>>(
      future: _fetchReplays(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UpComingTable>? data = snapshot.data;
          return Expanded(
            child: data!.length == 0
                ? Center(
                    child: Text('New pre-recording coming soon'),
                  )
                : _replayListView(data),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<UpComingTable>> _fetchReplays() async {
    final response = await http.get(
      Uri.parse(REPLAY_URL),
      headers: {"Content-Type": "application/json"},
    );

    print(response);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new UpComingTable.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load list of replays');
    }
  }

  ListView _replayListView(data) {
    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: 5.0,
      ),
      separatorBuilder: (context, index) => Divider(
        height: 3.0,
        color: Colors.black12,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: 0.5),
        child: replayCard(data[index], context, index),
      ),
    );
  }

  Widget replayCard(UpComingTable videosItem, BuildContext context, int index) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 96.0,
        maxHeight: 130.0,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 2.0, right: 3.0, top: 2.0, bottom: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFC4C4C4).withOpacity(index % 2 == 1 ? 0.21 : 0.51),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 94.0,
              height: 82.0,
              margin: const EdgeInsets.only(top: 5.0, left: 8.0, right: 10.0),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  Text(
                    videosItem.description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: const Color(0xFF01012A),
                    ),
                    softWrap: true,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Container(
              width: 65.0,
              padding: const EdgeInsets.only(
                top: 15.0,
                right: 10.0,
                left: 10.0,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReplayAudio(
                        audioFile: videosItem.replay_file,
                        title: videosItem.title,
                        album: videosItem.image_url,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    image: DecorationImage(
                      image: AssetImage('assets/replay.png'),
                      fit: BoxFit.fitHeight,
                    ),
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
