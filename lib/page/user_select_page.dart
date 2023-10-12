import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:what_time_is_it/app_state.dart';
import 'main_page.dart';

class UserSelectPage extends StatelessWidget {
  const UserSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameAppState>();

    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              state.setUser('민찬');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: const Text('민찬'),
          ),
          ElevatedButton(
            onPressed: () {
              state.setUser('민기');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: const Text('민기'),
          ),
        ],
      ),
    ));
  }
}
