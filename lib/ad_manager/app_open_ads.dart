import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honduras_weather/ad_manager/remove_ads.dart';
import '/core/services/services.dart';

class AppOpenAdManager extends GetxController with WidgetsBindingObserver {
  final RxBool isAdVisible = false.obs;
  final RemoveAds removeAdsController = Get.put(RemoveAds());
  AppOpenAd? _appOpenAd;
  bool _isAdAvailable = false;
  bool shouldShowAppOpenAd = true;
  bool isCooldownActive = false;
  bool _interstitialAdDismissed = false;
  bool _openAppAdEligible = false;
  bool isAppResumed = false;
  bool _isSplashInterstitialShown = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _openAppAdEligible = true;
    } else if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_openAppAdEligible && !_interstitialAdDismissed) {
          showAdIfAvailable();
        } else {
          print("Skipping Open App Ad (flags not met).");
        }
        _openAppAdEligible = false;
        _interstitialAdDismissed = false;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    initializeRemoteConfig();
  }

  Future<void> initializeRemoteConfig() async {
    try {
      await RemoteConfigService().init();
      final showAd = RemoteConfigService().getBool('AppOpenAd', 'AppOpenAd');
      if (showAd) {
        loadAd();
      }
    } catch (e) {
      debugPrint("Failed to initialize remote config: $e");
    }
  }

  void showAdIfAvailable() {
    if (removeAdsController.isSubscribedGet.value) {
      return;
    }
    if (_isAdAvailable && _appOpenAd != null && !isCooldownActive) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          isAdVisible.value = true;
        },
        onAdDismissedFullScreenContent: (ad) {
          _appOpenAd = null;
          _isAdAvailable = false;
          isAdVisible.value = false;
          loadAd();
          activateCooldown();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          _appOpenAd = null;
          _isAdAvailable = false;
          isAdVisible.value = false;
          loadAd();
        },
      );
      _appOpenAd!.show();
      _appOpenAd = null;
      _isAdAvailable = false;
    } else {
      loadAd();
    }
  }

  void activateCooldown() {
    isCooldownActive = true;
    Future.delayed(const Duration(seconds: 5), () {
      isCooldownActive = false;
    });
  }


  String _getAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8172082069591999/4084376708';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/8521820320';
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  void loadAd() {
    if (Platform.isIOS && removeAdsController.isSubscribedGet.value) {
      return;
    }
    if (!shouldShowAppOpenAd) return;
    AppOpenAd.load(
      adUnitId: _getAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAdAvailable = true;
        },
        onAdFailedToLoad: (error) {
          _isAdAvailable = false;
        },
      ),
    );
  }

  void setInterstitialAdDismissed() {
    _interstitialAdDismissed = true;
  }

  void setSplashInterstitialFlag(bool shown) {
    _isSplashInterstitialShown = shown;
  }

  void maybeShowAppOpenAd() {
    if (_isSplashInterstitialShown) {
      return;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _appOpenAd?.dispose();
    super.onClose();
  }
}
