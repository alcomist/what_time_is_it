import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'logo_page.dart';
import 'app_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '지금 몇시지?',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const LogoPage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        //localizationsDelegates: const [
        //  AppLocalizations.delegate,
        //  GlobalMaterialLocalizations.delegate,
        //  GlobalWidgetsLocalizations.delegate,
        //  GlobalCupertinoLocalizations.delegate,
        //],
        //supportedLocales: const [
        //  Locale('en'), // English
        //  Locale('ko'), // Korean
        //],
      ),
    );
  }
}
