import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  bool _regDirection = false;
  int _sinceSignIn = 0;

  bool get regDirection => _regDirection;
  int get sinceSignIn => _sinceSignIn;

  initialization() async {
    _amIRegistered();
  }

  _amIRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String regTime = DateTime.now().toString();

    final int _regD = (prefs.getInt('registered') ?? 0);
    regTime = (prefs.getString('reg_time') ?? regTime);

    _regDirection = _regD == 1 ? true : false;

    if (_regDirection) {
      _sinceSignIn = DateTime.now().difference(DateTime.parse(regTime)).inDays;
    }
    notifyListeners();
  }

  SignInRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registered', 1);
    notifyListeners();
  }

  RegisterMe(int id, String myName, String clientEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registered', 1);
    notifyListeners();
  }
}
