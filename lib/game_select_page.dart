import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'game_page.dart';

class GameSelectPage extends StatelessWidget {
  const GameSelectPage({Key? key}) : super(key: key);

  void _onPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GamePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('난이도 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                state.difficulty = GameDifficulty.easy;
                _onPressed(context);
              },
              icon: const Icon(Icons.star),
              label: const Text('쉬움'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                state.difficulty = GameDifficulty.normal;
                _onPressed(context);
              },
              icon: const Icon(Icons.star),
              label: const Text('보통'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                state.difficulty = GameDifficulty.hard;
                _onPressed(context);
              },
              icon: const Icon(Icons.star),
              label: const Text('어려움'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                state.difficulty = GameDifficulty.random;
                _onPressed(context);
              },
              icon: const Icon(Icons.star),
              label: const Text('아무거나'),
            ),
          ],
        ),
      ),
    );
  }
}
