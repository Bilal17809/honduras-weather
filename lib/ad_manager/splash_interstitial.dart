import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honduras_weather/ad_manager/remove_ads.dart';

import 'app_open_ads.dart';

class SplashInterstitialManager extends GetxController {
  InterstitialAd? _splashAd;
  bool isAdReady = false;
  var isShowing = false.obs;
  bool displaySplashAd = true;

  @override
  void onInit() {
    super.onInit();
    _initRemoteConfig();
    loadAd();
  }

  @override
  void onClose() {
    _splashAd?.dispose();
    super.onClose();
  }

  String get _adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8172082069591999/2413838868';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/9055370461';
    } else {
      throw UnsupportedError("Platform not supported");
    }
  }

  Future<void> _initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'SplashInterstitialAd';
      } else if (Platform.isIOS) {
        interstitialKey = 'SplashInterstitialAd';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
      await remoteConfig.fetchAndActivate();
      displaySplashAd = remoteConfig.getBool(interstitialKey);
      debugPrint("Splash Interstitial Ad Enabled: $showSplashAd");
      loadAd();
      update();
    } catch (e) {
      debugPrint('Error fetching Remote Config: $e');
      displaySplashAd = false;
    }
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _splashAd = ad;
          isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          isAdReady = false;
          debugPrint("Splash Interstitial load error: $error");
        },
      ),
    );
  }
  final removeAds = Get.find<RemoveAds>();
  void showSplashAd(VoidCallback onAdClosed) {
    if (!isAdReady || removeAds.isSubscribedGet.value) {
      debugPrint("Splash Interstitial not ready.");
      onAdClosed();
      return;
    }
    isShowing.value = true;

    _splashAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        Get.find<AppOpenAdManager>().setInterstitialAdDismissed();
        ad.dispose();
        isShowing.value = false;
        _resetAfterAd();
        onAdClosed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint("Splash Interstitial failed: $error");
        Get.find<AppOpenAdManager>().setInterstitialAdDismissed();
        ad.dispose();
        isShowing.value = false;
        _resetAfterAd();
        onAdClosed();
      },
    );

    _splashAd!.show();
    _splashAd = null;
    isAdReady = false;
  }

  void _resetAfterAd() {
    isAdReady = false;
    loadAd();
    update();
  }
}
