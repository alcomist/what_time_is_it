import 'dart:io' show Platform;

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class GameBannerPage extends StatefulWidget {
  const GameBannerPage({super.key});

  @override
  State<GameBannerPage> createState() => _GameBannerState();
}

class _GameBannerState extends State<GameBannerPage> {
  BannerAd? _bannerAd;
  bool _isSupported = false;

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

  // real admob unit id : ca-app-pub-5179012302510299/3194674433

  // TODO: replace this test ad unit with your own ad unit.
  // android test unit id : ca-app-pub-3940256099942544/2934735716';
  // ios test unit id : ca-app-pub-3940256099942544/6300978111
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2934735716'
      : 'ca-app-pub-3940256099942544/6300978111';

  Future<void> _loadAd() async {
    if (Platform.isAndroid || Platform.isIOS) {
      _isSupported = true;

      final AnchoredAdaptiveBannerAdSize? size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
              MediaQuery.of(context).size.width.truncate());

      if (size == null) {
        debugPrint('Unable to get height of anchored banner.');
        return;
      }

      BannerAd(
        adUnitId: adUnitId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$ad loaded: ${ad.responseInfo}');

            setState(() {
              // When the ad is loaded, get the ad size and use it to set
              // the height of the ad container.
              _bannerAd = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('Anchored adaptive banner failedToLoad: $error');
            ad.dispose();
          },
        ),
      ).load();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Widget _mockupBanner() {
    debugPrint('_mockupBanner');

    return const SizedBox.shrink();
  }

  Widget _banner() {
    if (_bannerAd == null) {
      return SizedBox(
        width: AdSize.largeBanner.width.toDouble(),
        height: AdSize.largeBanner.height.toDouble(),
      );
    }

    return SizedBox(
        width: AdSize.largeBanner.width.toDouble(),
        height: AdSize.largeBanner.height.toDouble(),
        child: AdWidget(ad: _bannerAd!));
  }

  @override
  Widget build(BuildContext context) {
    if (_isSupported == false) {
      return _mockupBanner();
    }

    return _banner();
  }
}
