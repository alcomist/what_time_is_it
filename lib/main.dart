import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'package:what_time_is_it/app_state.dart';
import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/parser.dart';
import 'package:what_time_is_it/route/delegate.dart';


// window width and height for Windows app
const double windowWidth = 480;
const double windowHeight = 854;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Animation Samples');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

void main() {
  setupWindow();

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
          //scaffoldBackgroundColor: Colors.green,
          colorSchemeSeed: Colors.purple,
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
