import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Text(AppLocalizations.of(context)!.appTitle,
            style: GoogleFonts.leckerliOne(fontSize: 40),
          ),
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
