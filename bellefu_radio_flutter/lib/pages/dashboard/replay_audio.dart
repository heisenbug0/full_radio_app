import 'package:bellefu/common/Constants.dart';
import 'package:bellefu/common/advert_bar.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class ReplayAudio extends StatefulWidget {
  const ReplayAudio({Key? key, required this.audioFile, required this.title, required this.album});
  final String audioFile;
  final String title;
  final String album;

  @override
  _ReplayAudioState createState() => new _ReplayAudioState();
}

class _ReplayAudioState extends State<ReplayAudio> with WidgetsBindingObserver {
  bool _isPlaying = false;
  double _value = 0;
  late double _audioLength = 100;

  @override
  void initState() {
    if (assetsAudioPlayer.isPlaying.value == true) {
      assetsAudioPlayer.stop();
    }
    super.initState();
    _initPlay();
  }

  Future<void> _initPlay() async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(
          widget.audioFile,
          metas: Metas(
            id: 'Online',
            title: 'Bellefu Agric Radio',
            artist: 'Bellefu program',
            album: widget.title,
            image: MetasImage.network(widget.album),
          ),
        ),
        showNotification: true,
        autoStart: false,
        notificationSettings: const NotificationSettings(nextEnabled: false, prevEnabled: false), // , stopEnabled: false
      );
      assetsAudioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (t) {
      //stream unreachable
      print(t.toString());
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      assetsAudioPlayer.stop();
    }
  }

  Future<bool> _onWillPop() async {
    if (_isPlaying) {
      assetsAudioPlayer.stop();
      Navigator.of(context).pop(true);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double _devWidth = MediaQuery.of(context).size.width;
    final double _devHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
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
                      return Text(
                        "Loading Replay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffa500),
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    } else {
                      return const Text(
                        "Replay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffa500),
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ); //empty
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: _devWidth * 0.75,
                    maxHeight: 56.0,
                  ),
                  child: Center(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  // height: 42.0,
                  width: _devWidth * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Slider(
                        min: 0.0,
                        max: _audioLength,
                        value: _value,
                        activeColor: Color(0xffffa500),
                        thumbColor: Color(0xffffa500),
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PlayerBuilder.currentPosition(
                                player: assetsAudioPlayer,
                                builder: (context, duration) {
                                  return Text(
                                    _printDuration(duration),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  );
                                }),
                            Text(
                              ".",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35.0,
                  vertical: 10.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _actionButton(1),
                    _replayButton(),
                    _actionButton(2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconStatus(int action) {
    switch (action) {
      case 0:
        return Image.asset(
          'assets/play_play.png',
          width: 45.0,
          height: 45.0,
        );
      case 1:
        return Image.asset(
          'assets/play_pause.png',
          width: 45.0,
          height: 45.0,
        );
      case 3:
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      case 4:
        return const SizedBox(width: 1.0);
      default:
        return const SizedBox(
          width: 0.0,
        );
    }
  }

  Widget _actionButton(int action) {
    return InkWell(
      onTap: () {
        if (_isPlaying) {
          if (action == 1) {
            assetsAudioPlayer.seek(Duration(seconds: -10));
          }
          if (action == 2) {
            assetsAudioPlayer.seekBy(Duration(seconds: 10));
          }
        }
      },
      child: Container(
        width: 74.0,
        height: 74.0,
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
          child: Image.asset(
            action == 1 ? 'assets/backward.png' : 'assets/forward.png',
            width: 44.0,
            height: 38.0,
          ),
        ),
      ),
    );
  }

  Widget _replayButton() {
    return InkWell(
      onTap: () async {
        try {
          if (_isPlaying) {
            assetsAudioPlayer.stop();
            setState(() {
              _isPlaying = false;
            });
            return;
          }
          _initPlay();
          /* await assetsAudioPlayer.open(
            Audio.liveStream(
              widget.audioFile,
              metas: Metas(
                id: 'Online',
                title: 'Bellefu Agric Radio',
                artist: 'Bellefu program replay',
                album: widget.title,
                image: MetasImage.network(widget.album),
              ),
            ),
            showNotification: true,
            autoStart: false,
            notificationSettings: const NotificationSettings(nextEnabled: false, prevEnabled: false), // , stopEnabled: false
          );
          assetsAudioPlayer.play();
          setState(() {
            _isPlaying = true;
          }); */
        } catch (t) {
          //stream unreachable
          print(t.toString());
        }
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
        child: Center(
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
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  _activateAction(int action) {}
}
