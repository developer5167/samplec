import 'dart:io';

import 'constants.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_BANNER;
    } else if (Platform.isIOS) {
      return IOS_BANNER;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_INTERSTITIAL;
    } else if (Platform.isIOS) {
      return IOS_INTERSTITIAL;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return ANDROID_REWARDED;
    } else if (Platform.isIOS) {
      return IOS_REWARDED;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}