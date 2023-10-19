import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import 'package:what_time_is_it/constants.dart';

import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/route/route.dart';

import 'package:what_time_is_it/page/user_select_page.dart';
import 'package:what_time_is_it/page/banner_page.dart';
import 'package:what_time_is_it/state/app_state.dart';

class _BrightnessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final setting = context.watch<AppSettingState>();
    final isBright = Theme.of(context).brightness == Brightness.light;

    return Tooltip(
      preferBelow: true,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () {
          setting.changeBrightness(!isBright);
        },
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final setting = context.watch<AppSettingState>();
    
    return PopupMenuButton(
      icon: Icon(
        Icons.palette_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a seed color',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != ColorSeed.baseColor,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == ColorSeed.baseColor
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: (index) {
        setting.changeColor(index);
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;

  PreferredSizeWidget createAppBar() {
    return AppBar(actions: [
      _BrightnessButton(),
      _ColorSeedButton(),
    ]);
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AnimationStatus status = controller.status;

    if (status != AnimationStatus.forward &&
        status != AnimationStatus.completed) {
      controller.forward();
    } else if (status != AnimationStatus.reverse &&
        status != AnimationStatus.dismissed) {
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
        child: Scaffold(
            appBar: createAppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AnalogClock(
                            key: _analogClockKey,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          notifier.changePage(page: PageNames.gameSelect.name);
                        },
                        child: Text(AppLocalizations.of(context)!.gameStart,
                            style: Theme.of(context).textTheme.headlineLarge),
                      ),
                    ],
                  ),
                ),
                const GameBannerPage(),
              ],
            )));
  }
}

class _MainPageStateOld extends State<MainPage> with TickerProviderStateMixin {
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;

  PreferredSizeWidget createAppBar() {
    return AppBar(actions: [
      _BrightnessButton(),
      _ColorSeedButton(),
    ]);
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final AnimationStatus status = controller.status;

    if (status != AnimationStatus.forward &&
        status != AnimationStatus.completed) {
      controller.forward();
    } else if (status != AnimationStatus.reverse &&
        status != AnimationStatus.dismissed) {
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return SafeArea(
        child: Scaffold(
            appBar: createAppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AnalogClock(
                            key: _analogClockKey,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          notifier.changePage(page: PageNames.gameSelect.name);
                        },
                        child: Text(AppLocalizations.of(context)!.gameStart,
                            style: Theme.of(context).textTheme.headlineLarge),
                      ),
                    ],
                  ),
                ),
                const GameBannerPage(),
              ],
            )));
  }
}
