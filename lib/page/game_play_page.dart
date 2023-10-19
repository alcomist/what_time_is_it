import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/route.dart';

import 'package:what_time_is_it/state/app_state.dart';
import 'package:what_time_is_it/app_localization.dart';

import 'banner_page.dart';

class GamePlayPage extends StatefulWidget {
  const GamePlayPage({super.key});

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage> {
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  final game = GameLogic();

  _exitDialog(BuildContext context, VoidCallback callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)!.quitMessage,
              textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  callback();
                },
                child: Text(AppLocalizations.of(context)!.answerYes)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.answerNo)),
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

    final style = Theme.of(context).textTheme.headlineSmall;

    showDialog(
      context: context,
      barrierDismissible: false,
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.answerCorrect,
                      textAlign: TextAlign.center,
                      style: style,
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.thumb_down,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.answerIncorrect,
                      textAlign: TextAlign.center,
                      style: style,
                    )
                  ],
                ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<GameAppState>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameAppState>();
    final notifier = Provider.of<PageNotifier>(context);

    game.difficulty = state.difficulty;
    game.generate();

    _analogClockKey.currentState?.dateTime = game.getTime();
    final questions = game.questions;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            AppLocalization.getDifficultyTitle(context, game.difficulty),
            style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            void onExit() {
              notifier.changePage(page: PageNames.gameSelect.name);
              //Navigator.of(context).pop();
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
              child: Text(
                  AppLocalizations.of(context)!
                      .currentGame(state.userAnswers.length + 1, 10),
                  style: Theme.of(context).textTheme.titleMedium),
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
                    return OutlinedButton(
                        onPressed: () {
                          var correct = game.isCorrect(index);
                          state.addUserAnswer(correct);
                          if (state.isEnd()) {
                            notifier.changePage(
                                page: PageNames.gameResult.name);
                          } else {
                            _gameResultDialog(context, correct, () {
                              setState(() {});
                            });
                          }
                        },
                        child: Text(
                            AppLocalization.getCurrentTime(
                                context, questions[index]),
                            style: Theme.of(context).textTheme.headlineSmall));
                  },
                ),
              ),
            ),
            const GameBannerPage(),
          ],
        ),
      ),
    );
  }
}
