import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_state.dart';

class Localizer {

  static String getCurrentTime(BuildContext context, Question question) {
    return AppLocalizations.of(context)!.currentTime(question.hour, question.minute);
  }

  static String getDifficultyTitle(BuildContext context, GameDifficulty difficulty) {
    return '${AppLocalizations.of(context)!.difficulty} : ${getDifficulty(context, difficulty)}';
  }

  static String getDifficulty(BuildContext context, GameDifficulty difficulty) {

    return switch(difficulty) {
      GameDifficulty.easy => AppLocalizations.of(context)!.difficultyEasy,
      GameDifficulty.normal => AppLocalizations.of(context)!.difficultyNormal,
      GameDifficulty.hard => AppLocalizations.of(context)!.difficultyHard,
      GameDifficulty.veryHard => AppLocalizations.of(context)!.difficultyVeryHard,
    };
  }

}