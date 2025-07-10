import 'package:assets_audio_player/assets_audio_player.dart';

class Constants {
  static const String BASE_API_URL = 'https://radio.bellefu.online/api';

  static const String LOGIN_URL = BASE_API_URL + '/login_user';
  static const String SIGN_UP_URL = BASE_API_URL + '/create_user';
  static const String UPCOMING_URL = BASE_API_URL + '/upcoming';
  static const String ADD_MY_SCHEDULE_URL = BASE_API_URL + '/add_schedule';
  static const String ADVERTS_URL = BASE_API_URL + '/adverts';
  static const String MY_SCHEDULE_URL = BASE_API_URL + '/get_my_schedule';

  static const String FORGOT_PASSWORD_URL = BASE_API_URL + '/forgot_password';
  static const String CONFIRM_KEY_URL = BASE_API_URL + '/confirm_keys';
  static const String SET_NEW_PASSWORD_URL = BASE_API_URL + '/set_newpassword';

  static const String CONTACT_US_URL = 'https://radio.bellefu.com/contact-us';
  static const String ABOUT_US_URL = 'https://radio.bellefu.com/about-us';
  static const String LINKS_URL = 'https://linktr.ee/Bellefu';

  static const String SERVER_STORAGE_URL = 'https://radio.bellefu.online/storage/';

  // static const streamUrl = "http://ia802708.us.archive.org/3/items/count_monte_cristo_0711_librivox/count_of_monte_cristo_001_dumas.mp3";
  // static const streamUrl = "http://server-23.stream-server.nl:8438";
  static const streamUrl = "https://stream.radiojar.com/v994btp2gd0uv"; // mp3
  // 'https://stream.radiojar.com/v994btp2gd0uv',
  // static const streamUrl = "https://stream.radiojar.com/v994btp2gd0uv.m3u"; // m3u
  // static const streamUrl = "https://stream.radiojar.com/v994btp2gd0uv.pls"; // PLS

}

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
