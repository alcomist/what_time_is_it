import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app_state.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  final game = GameLogic();

  showExit(BuildContext context, VoidCallback callback) {

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

  showResult(BuildContext context, bool correct, VoidCallback callback) {

    void close() {
      callback();
      Navigator.of(context).pop();
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

  String _getDifficulty(BuildContext context, GameDifficulty difficulty) {

    return switch(difficulty) {
      GameDifficulty.easy => AppLocalizations.of(context)!.difficultyEasy,
      GameDifficulty.normal => AppLocalizations.of(context)!.difficultyNormal,
      GameDifficulty.hard => AppLocalizations.of(context)!.difficultyHard,
      GameDifficulty.veryHard => AppLocalizations.of(context)!.difficultyVeryHard,
    };
  }

  @override
  Widget build(BuildContext context) {

    final state = context.watch<AppState>();

    game.difficulty = state.difficulty;
    game.generate(context);

    _analogClockKey.currentState?.dateTime = game.getTime();
    final questions = game.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.difficulty} : ${_getDifficulty(context, game.difficulty)}'),
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

            showExit(context, onExit);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
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
              flex: 2,
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

                          showResult(context, game.isCorrect(index), () {
                            setState(() {});
                          });
                        },
                        child: Text(questions[index],
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
