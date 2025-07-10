import 'package:bellefu/common/Constants.dart';
import 'package:bellefu/common/advert_bar.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayRadio extends StatefulWidget {
  PlayRadio({Key? key}) : super(key: key);

  @override
  _PlayRadioState createState() => _PlayRadioState();
}

class _PlayRadioState extends State<PlayRadio> {
  final bool _isBuffering = false;
  bool _isPlaying = false;

  @override
  void initState() {
    _isPlaying = assetsAudioPlayer.isPlaying.value;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _devWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff20222C),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 39.0,
                height: 39.0,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 15.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0x4c20222c),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff13151c),
                      blurRadius: 15,
                      offset: Offset(8, 8),
                    ),
                    BoxShadow(
                      color: Color(0xff2f323f),
                      blurRadius: 15,
                      offset: Offset(-6, -6),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff3a3d4b),
                      Color(0xff272934),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 25.0,
                    color: Color(0xffffd739),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: _devWidth,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AdvertBar(),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Align(
              alignment: Alignment.center,
              child: PlayerBuilder.isBuffering(
                player: assetsAudioPlayer,
                builder: (context, isBuffering) {
                  // return _isPlaying ? const SizedBox(width: 0.0) : _iconStatus(isBuffering ? 3 : 4);
                  if (isBuffering) {
                    return const FittedBox(
                      child: Text(
                        "Connecting to Live Broadcast",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffa500),
                          fontSize: 24,
                        ),
                      ),
                    );
                  } else {
                    return const FittedBox(
                      child: Text(
                        "Live Broadcast",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffa500),
                          fontSize: 24,
                        ),
                      ),
                    ); //empty
                  }
                },
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  _playAction();
                },
                child: Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffffa500),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff13151c),
                        blurRadius: 15,
                        offset: Offset(8, 8),
                      ),
                      BoxShadow(
                        color: Color(0xff2f323f),
                        blurRadius: 15,
                        offset: Offset(-6, -6),
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffb87207), Color(0xffffd800)],
                    ),
                  ),
                  child: _isPlaying
                      ? PlayerBuilder.isPlaying(
                          player: assetsAudioPlayer,
                          builder: (context, isPlaying) {
                            return _iconStatus(isPlaying ? 1 : 0);
                          },
                        )
                      : PlayerBuilder.isBuffering(
                          player: assetsAudioPlayer,
                          builder: (context, isBuffering) {
                            return _iconStatus(isBuffering ? 3 : 0);
                          },
                        ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FittedBox(
                  child: _bellefuAgric(),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _specialButton("Shout Out", Icons.favorite),
                const SizedBox(
                  width: 25.0,
                ),
                _specialButton("Live Chat", Icons.shuffle_outlined),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.150875,
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconStatus(int action) {
    switch (action) {
      case 0:
        return Center(
          child: Image.asset(
            'assets/play_play.png',
            width: 40.0,
            height: 40.0,
          ),
        );
      case 1:
        return Center(
          child: Image.asset(
            'assets/play_pause.png',
            width: 45.0,
            height: 45.0,
          ),
        );
      case 3:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      case 4:
        return const SizedBox(width: 1.0);
      default:
        return const SizedBox(
          width: 0.0,
        );
    }
  }

  Widget _specialButton(String title, IconData icon) {
    return Container(
      width: 151.0,
      height: 42.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0x4c20222c),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff13151c),
            blurRadius: 15,
            offset: Offset(8, 8),
          ),
          BoxShadow(
            color: Color(0xff2f323f),
            blurRadius: 15,
            offset: Offset(-6, -6),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff3a3d4b), Color(0xff272934)],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Color(0xffffa500),
            size: 20.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xccffffff),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  _playAction() async {
    if (_isPlaying) {
      assetsAudioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
      return;
    }

    try {
      if (_isPlaying == false) {
        await assetsAudioPlayer.open(
          Audio.liveStream(
            Constants.streamUrl,
            metas: Metas(
              id: 'Online',
              title: 'Bellefu Agric Radio',
              artist: 'Bellefu program',
              album: 'Live broadcast', // Program event title
              image: const MetasImage.asset('assets/to_radio.png'),
            ),
          ),
          showNotification: true,
          autoStart: false,
          notificationSettings: const NotificationSettings(nextEnabled: false, prevEnabled: false), // , stopEnabled: false
        );
        setState(() {
          _isPlaying = true;
        });
        assetsAudioPlayer.playOrPause();
      }
    } catch (t) {
      //stream unreachable
      print(t.toString());
    }
  }

  Widget _bellefuAgric() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 35.0,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bellefu",
              style: TextStyle(
                color: Color(0xffffa500),
                fontSize: 24.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 5.33),
            Text(
              "Agriculture ",
              style: TextStyle(
                color: Color(0xff76b91b),
                fontSize: 24.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 5.33),
            Text(
              "Radio",
              style: TextStyle(
                color: Color(0xffffa500),
                fontSize: 24.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
