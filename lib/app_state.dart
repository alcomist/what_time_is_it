import 'dart:math';
import 'package:flutter/material.dart';

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

class AppState extends ChangeNotifier {

  String user = '';
  GameDifficulty difficulty = GameDifficulty.easy;

  late List<bool> _userAnswers;

  List<bool> get userAnswers => _userAnswers;

  AppState() {
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
    notifyListeners();
  }

  void setUser(user) {
    this.user = user;
  }

  String getUser() {
    return user;
  }
}
