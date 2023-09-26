import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum GameDifficulty {
  easy,
  normal,
  hard,
  veryHard,
}

typedef Question = ({int hour, int minute});

class GameLogic {

  late GameDifficulty difficulty;
  late List<Question> _questions = List<Question>.filled(4, (hour: 0, minute: 0));

  final List<bool> _userAnswers = [];

  int _hour = 0;
  int _minute = 0;
  int _answer = 0;

  void _init() {
    _questions = List<Question>.filled(4, (hour: 0, minute: 0));
  }

  List<Question> get questions => _questions;

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
    return switch (difficulty) {
      GameDifficulty.easy => 0, // 정각
      GameDifficulty.normal => Random().nextInt(6) * 10, // 10분 단위
      GameDifficulty.hard => Random().nextInt(12) * 5, // 5분 단위
      GameDifficulty.veryHard => Random().nextInt(60), // 1분 단위
    };
  }

  void generate() {

    _hour = _randomHour();
    _minute = _randomMinute();

    _answer = Random().nextInt(4);

    _init();

    //_questions[_answer] = AppLocalizations.of(context)!.currentTime(_hour, _minute);
    _questions[_answer] = (hour: _hour, minute:_minute);

    for (var i = 0; i < 4; i++) {
      if (i == _answer) continue;

      while (true) {
        //var question = AppLocalizations.of(context)!.currentTime(_randomHour(), _randomMinute());
        final question = (hour: _randomHour(), minute: _randomMinute());
        if (_questions.contains(question)) {
          continue;
        }

        _questions[i] = question;
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

  bool isEnd() {
    return _userAnswers.length == 10;
  }

  int userAnswersLength() {
    return _userAnswers.length;
  }

  void addUserAnswer(bool correct) {
    _userAnswers.add(correct);
  }
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
