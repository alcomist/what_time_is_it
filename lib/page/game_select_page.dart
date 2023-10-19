import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:what_time_is_it/route/route.dart';
import 'package:what_time_is_it/route/notifier.dart';

import 'package:what_time_is_it/state/app_state.dart';
import 'package:what_time_is_it/page/game_play_page.dart';

import 'banner_page.dart';

class GameSelectPage extends StatelessWidget {
  const GameSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;

    final buttonStyle =
        ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(100));

    final state = context.watch<GameAppState>();
    final notifier = Provider.of<PageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.chooseDifficulty,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            notifier.changePage(page: PageNames.main.name);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    style: buttonStyle,
                    onPressed: () {
                      state.difficulty = GameDifficulty.easy;
                      notifier.changePage(page: PageNames.gamePlay.name);
                    },
                    icon: const Icon(Icons.directions_walk),
                    label: Text(AppLocalizations.of(context)!.difficultyEasy,
                        style: textStyle),
                  ),
                  OutlinedButton.icon(
                    style: buttonStyle,
                    onPressed: () {
                      state.difficulty = GameDifficulty.normal;
                      notifier.changePage(page: PageNames.gamePlay.name);
                    },
                    icon: const Icon(Icons.directions_run),
                    label: Text(AppLocalizations.of(context)!.difficultyNormal,
                        style: textStyle),
                  ),
                  OutlinedButton.icon(
                    style: buttonStyle,
                    onPressed: () {
                      state.difficulty = GameDifficulty.hard;
                      notifier.changePage(page: PageNames.gamePlay.name);
                    },
                    icon: const Icon(Icons.directions_bike),
                    label: Text(AppLocalizations.of(context)!.difficultyHard,
                        style: textStyle),
                  ),
                  OutlinedButton.icon(
                    style: buttonStyle,
                    onPressed: () {
                      state.difficulty = GameDifficulty.veryHard;
                      notifier.changePage(page: PageNames.gamePlay.name);
                    },
                    icon: const Icon(Icons.psychology_alt),
                    label: Text(
                        AppLocalizations.of(context)!.difficultyVeryHard,
                        style: textStyle),
                  ),
                ],
              ),
            ),
            const GameBannerPage(),
          ],
        ),
      ),
    );
  }
}
