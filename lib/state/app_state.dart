import 'dart:math';

import 'package:flutter/material.dart';
import 'package:what_time_is_it/constants.dart';

enum GameDifficulty {
  easy,
  normal,
  hard,
  veryHard,
}

typedef Question = ({int hour, int minute});

class GameLogic {
  late Question _answer;
  late int _answerIndex;
  late GameDifficulty difficulty;

  late List<Question> _questions;

  GameLogic() {
    _answer = (hour: 0, minute: 0);
    _answerIndex = 0;
    _questions = List<Question>.filled(4, (hour: 0, minute: 0));
  }

  List<Question> get questions => _questions;

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
    _answer = (hour: _randomHour(), minute: _randomMinute());
    _answerIndex = Random().nextInt(4);

    _questions[_answerIndex] = _answer;

    for (var i = 0; i < 4; i++) {
      if (i == _answerIndex) continue;

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
    return DateTime(2023, 6, 7, _answer.hour, _answer.minute);
  }

  bool isCorrect(int index) {
    return _answerIndex == index;
  }
}

class GameAppState extends ChangeNotifier {
  String user = '';
  GameDifficulty difficulty = GameDifficulty.easy;

  late List<bool> _userAnswers;

  List<bool> get userAnswers => _userAnswers;

  GameAppState() {
    init();
  }

  void init() {
    _userAnswers = [];
  }

  bool isEnd() {
    return _userAnswers.length == 10;
  }

  int userAnswersLength() {
    return _userAnswers.length;
  }

  void addUserAnswer(bool correct) {
    _userAnswers.add(correct);
    //notifyListeners();
  }

  (int correct, int incorrect) getResult() {
    return (
      _userAnswers.where((element) => element == true).toList().length,
      _userAnswers.where((element) => element == false).toList().length
    );
  }

  void setUser(user) {
    this.user = user;
  }

  String getUser() {
    return user;
  }
}

class AppSettingState extends ChangeNotifier {

  ColorSeed colorSelected = ColorSeed.baseColor;
  ThemeMode themeMode = ThemeMode.dark;

  void setThemeMode(BuildContext context) {
    if ( View.of(context).platformDispatcher.platformBrightness == Brightness.light ) {
      themeMode = ThemeMode.light;
      return;
    }
    themeMode = ThemeMode.dark;
  }

  bool useLightMode(BuildContext context) {

    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness == Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void changeBrightness(bool useLightMode) {
    themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void changeColor(int value) {
    colorSelected = ColorSeed.values[value];
    notifyListeners();
  }
}
