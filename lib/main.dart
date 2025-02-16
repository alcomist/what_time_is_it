import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'package:what_time_is_it/constants.dart';
import 'package:what_time_is_it/state/app_state.dart';
import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/parser.dart';
import 'package:what_time_is_it/route/delegate.dart';

// window width and height for Windows app
const double windowWidth = 600;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('지금 몇 시일까요?');
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PageNotifier>(create: (_) => PageNotifier()),
      ChangeNotifierProvider<GameAppState>(create: (_) => GameAppState()),
      ChangeNotifierProvider<AppSettingState>(create: (_) => AppSettingState()),
    ], child: const MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final setting = context.watch<AppSettingState>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate:
          AppRouterDelegate(notifier: Provider.of<PageNotifier>(context)),
      title: 'What time is it?',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: setting.themeMode,
      theme: ThemeData(
        colorSchemeSeed: setting.colorSelected.color,
        useMaterial3: setting.useMaterial3,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: setting.colorSelected.color,
        useMaterial3: setting.useMaterial3,
        brightness: Brightness.dark,
      ),
    );
  }
}
