import 'dart:math';
import 'package:flutter/material.dart';

enum GameDifficulty {
  easy,
  normal,
  hard,
  random,
}

class GameLogic {
  late GameDifficulty _difficulty;

  set difficulty(GameDifficulty difficulty) {
    _difficulty = difficulty;
  }

  int _hour = 0;
  int _minute = 0;
  int _answer = 0;

  List<String> _questions = List<String>.filled(4, '');

  void _initQuestions() {
    _questions = List<String>.filled(4, '');
  }

  String _clockString(int hour, int minute) {
    if (minute == 0) {
      return '$hour시 정각';
    }

    return '$hour시 $minute분';
  }

  int _randomHour() {
    return Random().nextInt(12) + 1;
  }

  int _randomMinute() {
    return switch (_difficulty) {
      GameDifficulty.easy => 0, // 정각
      GameDifficulty.normal => Random().nextInt(6) * 10, // 10분 단위
      GameDifficulty.hard => Random().nextInt(12) * 5, // 5분 단위
      GameDifficulty.random => Random().nextInt(60), // 1분 단위
    };
  }

  void generate() {
    _hour = _randomHour();
    _minute = _randomMinute();

    _answer = Random().nextInt(4);

    _initQuestions();

    _questions[_answer] = _clockString(_hour, _minute);

    for (var i = 0; i < 4; i++) {
      if (i == _answer) continue;

      while (true) {
        var str = _clockString(_randomHour(), _randomMinute());
        if (_questions.contains(str)) {
          continue;
        }

        _questions[i] = str;
        break;
      }
    }
  }

  DateTime getTime() {
    return DateTime(2023, 6, 7, _hour, _minute);
  }

  bool isCorrect(int index) {
    return _answer == index;
  }

  List<String> get questions => _questions;
}

class AppState extends ChangeNotifier {

  String user = '';
  GameDifficulty difficulty = GameDifficulty.easy;

  AppState();

  void setUser(user) {
    this.user = user;
  }

  String getUser() {
    return user;
  }

  void toggleFavorite() {
    notifyListeners();
  }

  void removeFavorite() {
    notifyListeners();
  }
}
