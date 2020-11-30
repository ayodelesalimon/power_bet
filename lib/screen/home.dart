import 'package:admob_flutter/admob_flutter.dart';
import 'package:bet_app/models/ads.dart';
import 'package:bet_app/screen/freetips.dart';
import 'package:bet_app/screen/viptips.dart';
import 'package:bet_app/widgets/buttons.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;
  var idAds = AdsUnit();

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: idAds.getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        //handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
      adUnitId: idAds.getRewardBasedVideoAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        //handleEvent(event, args, 'Reward');
      },
    );

    interstitialAd.load();
    rewardAd.load();
  }

  checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar('No internet connectivity');
      return;
    }
  }

  @override
  void setState(fn) {
    super.setState(fn);
    bannerSize = AdmobBannerSize.BANNER;
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    //subscription.cancel();

    super.dispose();
  }

  //Create snackBar to display error
  void showSnackBar(String title) {
    final snackBar = new SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/ball.jpg'),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Text(
                  "POWER BET",
                  style: TextStyle(fontSize: 40.0, color: Colors.white30),
                ),
                SizedBox(height: 20),
                ButtonTap(
                  onTap: () async {
                    if (await interstitialAd.isLoaded) {
                      interstitialAd.show();
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FreeTips();
                    }));
                  },
                  title: "FREE TIPS",
                  color: Colors.white,
                  img: Icons.star,
                  imgg: Icons.star,
                ),
                SizedBox(
                  height: 5.0,
                ),
                ButtonTap(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FreeTips()),
                    );
                  },
                  title: "VIP TIPS",
                  color: Colors.yellow,
                  img: Icons.star,
                  imgg: Icons.star,
                ),
                SizedBox(
                  height: 5.0,
                ),
                ButtonTap(
                  onTap: () async {
                    if (await rewardAd.isLoaded) {
                      rewardAd.show();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VipTips()),
                    );
                  },
                  title: "VIP OLD TIPS",
                  color: Colors.white,
                  img: Icons.star,
                  imgg: Icons.star,
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.black,
                      content: Text(
                        'Terms & Condtion Accepted',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Center(
                    child: Text(
                      "PRIVACY POLICY",
                      style: TextStyle(fontSize: 20.0, color: Colors.white30),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 70.0,
                // ),
                // Container(
                //   height: 100,
                //   width: 600,
                //   child: AdmobBanner(
                //     adUnitId: idAds.getBannerAdUnitId(),
                //     adSize: bannerSize,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: 500,
        child: AdmobBanner(
          adUnitId: idAds.getBannerAdUnitId(),
          adSize: bannerSize,
        ),
      ),
    );
  }
}
