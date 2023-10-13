import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameBanner {

  static final GameBanner _instance = GameBanner._internal(); //_internal : private 생성자
  GameBanner._internal();

  factory GameBanner() {
    return _instance;
  }

  GameBanner get instance => _instance;

  BannerAd? _bannerAd;


  bool _isLoaded = false;
  bool _isAvailable = false;

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

  Future<void> load(BuildContext context) async {

    if (Platform.isAndroid || Platform.isIOS) {

      if ( _isLoaded ) {
        return;
      }

      _isAvailable = true;

      AnchoredAdaptiveBannerAdSize? size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          MediaQuery.of(context).size.width.truncate());

      if ( size == null ) {
        return;
      }

      BannerAd(

        adUnitId: adUnitId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('$ad loaded: ${ad.responseInfo}');
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            debugPrint('Anchored adaptive banner failedToLoad: $error');
            ad.dispose();
          },
        ),
      ).load();
    }
  }

  bool get isLoaded => _isLoaded;

  Widget banner() {

    if (_isAvailable) {

      if (_isLoaded ) {

        return SizedBox(
            width: _bannerAd?.size.width.toDouble(),
            height: _bannerAd?.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!));
      }

      return SizedBox(
        width: AdSize.largeBanner.width.toDouble(),
        height: AdSize.largeBanner.height.toDouble(),
      );

    } else {
      return const SizedBox.shrink();
    }
  }
}
