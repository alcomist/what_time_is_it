import 'package:flutter/material.dart';
import 'user_select_page.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Text('지금 몇시지?'),
          const SizedBox(
            height: 30,
          ),
          ClipOval(
            child: Image.asset('assets/logo.jpg', width: 300),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserSelectPage()),
              );
            },
            child: Text('시작', style: style),
          ),
        ],
      ),
    )));
  }
}
