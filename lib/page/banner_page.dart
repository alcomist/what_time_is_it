import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class GameBannerPage extends StatefulWidget {
  const GameBannerPage({super.key});

  @override
  State<GameBannerPage> createState() => _BannerBannerState();
}

class _BannerBannerState extends State<GameBannerPage> {

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // AdMob test id
  //앱 오프닝 광고 : ca-app-pub-3940256099942544/3419835294
  //적응형 배너	: ca-app-pub-3940256099942544/9214589741
  //배너	: ca-app-pub-3940256099942544/6300978111
  //전면 광고	: ca-app-pub-3940256099942544/1033173712
  //동영상 전면 광고	: ca-app-pub-3940256099942544/8691691433
  //보상형 광고	: ca-app-pub-3940256099942544/5224354917
  //보상형 전면 광고	: ca-app-pub-3940256099942544/5354046379
  //네이티브 광고 고급형 : ca-app-pub-3940256099942544/2247696110
  //네이티브 광고 고급형 동영상 : ca-app-pub-3940256099942544/1044960115
  //ca-app-pub-3940256099942544/6300978111

  // real admob unit id : ca-app-pub-5179012302510299/3194674433

  // TODO: replace this test ad unit with your own ad unit.
  // android test unit id : ca-app-pub-3940256099942544/2934735716';
  // ios test unit id : ca-app-pub-3940256099942544/6300978111
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2934735716'
      : 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid || Platform.isIOS) {
      BannerAd(
        size: AdSize.largeBanner,
        adUnitId: adUnitId,
        request: const AdRequest(),
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            _bannerAd = ad as BannerAd;

            debugPrint('$ad loaded.');

            setState(() {
              _isLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd == null
        ? const SizedBox.shrink()
        : SizedBox(
            //width: _bannerAd!.size.width.toDouble(),
            width: double.infinity,
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          );
  }
}
