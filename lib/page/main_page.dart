import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/route.dart';

import 'package:what_time_is_it/page/user_select_page.dart';
import 'package:what_time_is_it/page/banner_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnalogClock(
                    key: _analogClockKey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  notifier.changePage(page: PageNames.gameSelect.name);
                },
                child: Text(AppLocalizations.of(context)!.gameStart,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ],
          ),
        ),
        const GameBannerPage(),
      ],
    )));
  }
}
