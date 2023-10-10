import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:what_time_is_it/route/route.dart';
import 'package:what_time_is_it/route/notifier.dart';

import 'package:what_time_is_it/app_state.dart';
import 'package:what_time_is_it/page/game_play_page.dart';

class GameSelectPage extends StatelessWidget {

  const GameSelectPage({Key? key}) : super(key: key);

  static const TextStyle textStyle = TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {

    final buttonStyle = ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(100));

    final state = context.watch<AppState>();
    final notifier = Provider.of<PageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chooseDifficulty),
      ),
      body:
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: buttonStyle,
                  onPressed: () {
                    state.difficulty = GameDifficulty.easy;
                    notifier.changePage(page: PageName.gamePlay.name);
                  },
                  icon: const Icon(Icons.directions_walk),
                  label: Text(AppLocalizations.of(context)!.difficultyEasy, style: textStyle),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: buttonStyle,
                  onPressed: () {
                    state.difficulty = GameDifficulty.normal;
                    notifier.changePage(page: PageName.gamePlay.name);
                  },
                  icon: const Icon(Icons.directions_run),
                  label: Text(AppLocalizations.of(context)!.difficultyNormal, style: textStyle),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: buttonStyle,
                  onPressed: () {
                    state.difficulty = GameDifficulty.hard;
                    notifier.changePage(page: PageName.gamePlay.name);
                  },
                  icon: const Icon(Icons.directions_bike),
                  label: Text(AppLocalizations.of(context)!.difficultyHard, style: textStyle),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: buttonStyle,
                  onPressed: () {
                    state.difficulty = GameDifficulty.veryHard;
                    notifier.changePage(page: PageName.gamePlay.name);
                  },
                  icon: const Icon(Icons.psychology_alt),
                  label: Text(AppLocalizations.of(context)!.difficultyVeryHard, style: textStyle),
                ),
              ],
          ),
        ),
      );
  }
}
