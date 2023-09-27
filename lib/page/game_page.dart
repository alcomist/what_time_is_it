import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app_state.dart';
import '../localizer.dart';
import 'game_result_page.dart';

class GamePage extends StatefulWidget {

  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  final game = GameLogic();

  _exitDialog(BuildContext context, VoidCallback callback) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)!.quitMessage, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
              callback();
            }, child: Text(AppLocalizations.of(context)!.answerYes)),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text(AppLocalizations.of(context)!.answerNo)),
          ],
        );
      },
    );
  }

  _gameResultDialog(BuildContext context, bool correct, VoidCallback callback) {

    void close() {
      Navigator.of(context).pop();
      callback();
    }

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      close();
      timer.cancel();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: correct
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.blueAccent,
                    ),
                    Text(AppLocalizations.of(context)!.answerCorrect, textAlign: TextAlign.center)
                  ],
          )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.thumb_down,
                color: Colors.redAccent,
              ),
              Text(AppLocalizations.of(context)!.answerIncorrect, textAlign: TextAlign.center)
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {

    final state = context.watch<AppState>();

    game.difficulty = state.difficulty;
    game.generate();

    _analogClockKey.currentState?.dateTime = game.getTime();
    final questions = game.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text(Localizer.getDifficultyTitle(context, game.difficulty)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {

            void onExit() {
              Navigator.of(context).pop();
            }

            _exitDialog(context, onExit);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.currentGame(state.userAnswers.length+1, 10)),
            ),
            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AnalogClock(
                    key: _analogClockKey,
                    secondHandWidthFactor: 0,
                    secondHandLengthFactor: 0,
                    dateTime: game.getTime(),
                    isKeepTime: false,
                  ),
                )),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  itemCount: 4, //item 개수
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 8, //item 의 가로 8, 세로 1 의 비율
                    mainAxisSpacing: 10, //수평 Padding
                    crossAxisSpacing: 10, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //item 의 반목문 항목 형성
                    return ElevatedButton(
                        onPressed: () {

                          var correct = game.isCorrect(index);
                          state.addUserAnswer(correct);
                          if ( state.isEnd() ) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GameResultPage()),
                            );
                          }

                          _gameResultDialog(context, correct, () {

                          });
                        },
                        child: Text(Localizer.getCurrentTime(context, questions[index]),
                            style: Theme.of(context).textTheme.headlineSmall));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
