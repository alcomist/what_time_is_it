import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/route.dart';

import 'package:what_time_is_it/page/user_select_page.dart';
import 'package:what_time_is_it/page/banner_page.dart';

class LogoPage extends StatelessWidget {
  LogoPage({super.key});

  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.appTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          //ClipOval(
          //  child: Image.asset('assets/logo.jpg', width: 300),
          //),
          //const SizedBox(
          //  height: 30,
          //),
          Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: AnalogClock(
                  key: _analogClockKey,
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              notifier.changePage(page: PageNames.gameSelect.name);
              //Navigator.push(
              //  context,
              //  MaterialPageRoute(builder: (context) => const UserSelectPage()),
              //);
            },
            child: Text(AppLocalizations.of(context)!.gameStart,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          //Expanded(
          //  child: Container(),
          //),
          const GameBannerPage(),
        ],
      ),
    )));
  }
}
