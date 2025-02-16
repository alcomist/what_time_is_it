import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'state/app_state.dart';

class AppLocalization {
  static String getCurrentTime(BuildContext context, Question question) {
    return AppLocalizations.of(context)!
        .currentTime(question.hour, question.minute);
  }

  static String getDifficultyTitle(
      BuildContext context, GameDifficulty difficulty) {
    return '${AppLocalizations.of(context)!.difficulty} : ${getDifficulty(context, difficulty)}';
  }

  static String getDifficulty(BuildContext context, GameDifficulty difficulty) {
    return switch (difficulty) {
      GameDifficulty.easy => AppLocalizations.of(context)!.difficultyEasy,
      GameDifficulty.normal => AppLocalizations.of(context)!.difficultyNormal,
      GameDifficulty.hard => AppLocalizations.of(context)!.difficultyHard,
      GameDifficulty.veryHard =>
        AppLocalizations.of(context)!.difficultyVeryHard,
    };
  }

  static String getGameResultMessage(BuildContext context, int score) {
    return switch (score) {
      10 => AppLocalizations.of(context)!.gameResultExcellent,
      >= 5 && <= 9 => AppLocalizations.of(context)!.gameResultVeryGood,
      >= 1 && <= 4 => AppLocalizations.of(context)!.gameResultGood,
      0 => AppLocalizations.of(context)!.gameResultPoor,
      int() => 'invalid',
    };
  }
}
