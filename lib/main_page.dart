import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:whattimeisit/game_select_page.dart';

import 'app_state.dart';
import 'user_select_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    final state = context.watch<AppState>();

    final theme = Theme.of(context);

    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return SafeArea(
        child: Scaffold(
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
                MaterialPageRoute(builder: (context) => const GameSelectPage()),
              );
            },
            child: Text('난이도 선택', style: style),
          ),
        ],
      ),
    )));
  }
}
