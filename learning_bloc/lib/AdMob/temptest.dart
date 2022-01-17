// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob extends StatefulWidget {
  const Admob({Key? key}) : super(key: key);

  @override
  _AdmobState createState() => _AdmobState();
}

class _AdmobState extends State<Admob> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
        // Change Banner Size According to Ur Need
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, LoadAdError error) {
        //  print("Failed to Load A Banner Ad${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request:  const AdRequest())
      ..load();
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print("failed to Load Interstitial Ad ${error.message}");
        }));

    // _loadRewardedAd();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Align(alignment: Alignment.center, child: AdWidget(ad: _bannerAd)),
        Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: _isInterstitialAdReady ? _interstitialAd.show : null,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("interstitial Ad"),
                )))
      ]),
    );

    
  }
  
  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }
}
