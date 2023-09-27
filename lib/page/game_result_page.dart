import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:what_time_is_it/app_state.dart';
import 'package:what_time_is_it/localizer.dart';
import 'package:what_time_is_it/big_card.dart';
import 'package:what_time_is_it/page/game_select_page.dart';

class GameResultPage extends StatefulWidget {

  const GameResultPage({super.key});

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {

  _exitDialog(BuildContext context, VoidCallback callback) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context)!.quitToGameSelectMessage, textAlign: TextAlign.center),
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = context.watch<AppState>();

    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {

              void onExit() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameSelectPage()),
                );
              }

              _exitDialog(context, onExit);
            },
          ),
          title: Text(AppLocalizations.of(context)!.gameResult),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.gameResult),
              Text('맞음 : ${state.getResult().$1}'),
              Text('틀림 : ${state.getResult().$2}'),
              BigCard(message: Localizer.getGameResultMessage(context, state.getResult().$1)),
            ],
          ),
        )
      ),
    );
  }
}


