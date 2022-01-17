// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:learning_bloc/AdMob/temptest.dart';
import 'ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TempTest2 extends StatefulWidget {
  const TempTest2({Key? key}) : super(key: key);

  @override
  _TempTest2State createState() => _TempTest2State();
}

class _TempTest2State extends State<TempTest2> {
  late BannerAd _bannerAd;

  // ignore: prefer_final_fields
  late bool _isBannerAdReady = false;

  late InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady = false;

  bool _isRewardedAdReady = false;

  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    //_bannerAd(); 
    //Interstitial Ads
    _interstitialAds();
    _loadRewardedAd();
  }
  void _interstitialAds() {
  InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          print("failed to Load Interstitial Ad ${error.message}");
        }));}

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
        _rewardedAd = ad;
        ad.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          setState(() {
            _isRewardedAdReady = false;
          });
          _loadRewardedAd();
        });
        setState(() {
          _isRewardedAdReady = true;
        });
      }, onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        setState(() {
          _isRewardedAdReady = false;
        });
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
          IconButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Admob(),
                  ),
                );
              },
              icon: const Icon(Icons.add_alarm))
        ],
          title: Text("Flutter Mobile Ads"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Simple Container
                Container(
                  height: 70,
                  color: Colors.red,
                ),
                SizedBox(height: 20),
                //Simple Container
                Container(
                  height: 70,
                  color: Colors.indigo,
                ),
                SizedBox(height: 20),
                if (_isBannerAdReady)
                  Container(
                    height: _bannerAd.size.height.toDouble(),
                    width: _bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                SizedBox(height: 20),
                Container(
                  height: 70,
                  color: Colors.deepOrange,
                ),
                SizedBox(height: 20),
                Container(
                  height: 70,
                  color: Colors.purple,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed:
                        _isInterstitialAdReady ? _interstitialAd.show : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("interstitial Ad"),
                    )),
                if (_isRewardedAdReady)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Need a hint?'),
                            content: Text('Watch an Ad to get a hint!'),
                            actions: [
                              TextButton(
                                child: Text('cancel'.toUpperCase()),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('ok'.toUpperCase()),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _rewardedAd?.show(
                                    onUserEarnedReward: (_, reward) {
                                      // QuizManager.instance.useHint();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("hint"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}