import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:what_time_is_it/app_state.dart';
import 'package:what_time_is_it/page/game_select_page.dart';

import 'user_select_page.dart';
import '../bottom_menu.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameAppState>();

    final theme = Theme.of(context);

    // ↓ Add this.
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('메인 페이지'),
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
      ),

      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(child: Text(state.getUser())),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AnalogClock(
                        key: _analogClockKey,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GameSelectPage()),
                );
              },
              child: Text(AppLocalizations.of(context)!.chooseDifficulty,
                  style: style),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: const BottomMenu(),
    ));
  }
}
