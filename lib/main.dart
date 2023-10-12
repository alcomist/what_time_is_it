import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/parser.dart';
import 'package:what_time_is_it/route/delegate.dart';

import 'package:what_time_is_it/page/logo_page.dart';

import 'package:what_time_is_it/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  if (kDebugMode) {
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ['42ABE9B8A4BD7D6A8AFB3A3F616A11BF']));
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PageNotifier>(create: (context) => PageNotifier()),
      ChangeNotifierProvider<GameAppState>(create: (_) => GameAppState()),
    ], child: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: AppRouteInformationParser(),
        routerDelegate:
            AppRouterDelegate(notifier: Provider.of<PageNotifier>(context)),
        title: 'What time is it?',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
          brightness: Brightness.dark,
        ));
  }
}

class MainAppOld extends StatelessWidget {
  const MainAppOld({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What time is it?',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 10,
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            ),
          ).titleLarge,
        ),
      ),
      //home: const LogoPage(),
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
    );
  }
}
