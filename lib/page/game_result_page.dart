import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/route.dart';

import 'package:what_time_is_it/app_state.dart';
import 'package:what_time_is_it/app_localization.dart';
import 'package:what_time_is_it/big_card.dart';
import 'package:what_time_is_it/page/game_select_page.dart';

import 'banner_page.dart';

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
          content: Text(AppLocalizations.of(context)!.quitToGameSelectMessage,
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameAppState>();
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                void onExit() {
                  notifier.changePage(page: PageNames.gameSelect.name);
                }

                _exitDialog(context, onExit);
              },
            ),
            title: Text(AppLocalizations.of(context)!.gameResult,
                style: Theme.of(context).textTheme.titleLarge),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '맞음 : ${state.getResult().$1}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '틀림 : ${state.getResult().$2}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                BigCard(
                    message: AppLocalization.getGameResultMessage(
                        context, state.getResult().$1)),
                const GameBannerPage(),
              ],
            ),
          )),
    );
  }
}
