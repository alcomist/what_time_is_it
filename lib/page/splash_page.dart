import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:what_time_is_it/state/app_state.dart';

import 'package:google_fonts/google_fonts.dart';

import '../route/notifier.dart';
import '../route/route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ClipOval(
              child: Image.asset('assets/logo.jpg', width: 300),
            ),
          ),
          Text(
            '30K DEV',
            style: GoogleFonts.leckerliOne(fontSize: 40),
          ),
        ],
      ),
    ));
  }
}
