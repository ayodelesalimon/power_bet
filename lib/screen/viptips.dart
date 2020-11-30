import 'package:admob_flutter/admob_flutter.dart';
import 'package:bet_app/models/ads.dart';
import 'package:bet_app/screen/webview.dart';
import 'package:bet_app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class VipTips extends StatefulWidget {
  @override
  _VipTipsState createState() => _VipTipsState();
}

class _VipTipsState extends State<VipTips> {
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;
  var idAds= AdsUnit();

  @override
  void initState() {
    super.initState();
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
  //String url = "https://www.betensured.com/predictions";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(2), BlendMode.dstATop),
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
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Text("POWER BET",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  ButtonTap(
                    onTap: () async {
                      if (await rewardAd.isLoaded) {
                    rewardAd.show();
                  }
                      //https://www.betensured.com/predictions

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BettingView(
                            blogUrl: 'https://mrbankstips.com/',
                          ),
                        ),
                      );
                    },
                    title: "VIP ODDS",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  ButtonTap(
                    //https://www.over25tips.com/
                    onTap: () async {
                      if (await interstitialAd.isLoaded) {
                    interstitialAd.show();
                  }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BettingView(
                            blogUrl: 'https://www.over25tips.com/',
                          ),
                        ),
                      );
                    },
                    title: "VIP 2.5 ODDS",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  ButtonTap(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BettingView(
                            blogUrl:
                                'https://www.squawka.com/en/bet/football-tips/btts-tips/',
                          ),
                        ),
                      );
                    },
                    title: "VIP BTTS TIPS",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  ButtonTap(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BettingView(
                            blogUrl: 'https://www.over25tips.com/',
                          ),
                        ),
                      );
                    },
                    title: "TIPS",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  ButtonTap(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BettingView(
                            blogUrl: 'https://www.over25tips.com/',
                          ),
                        ),
                      );
                    },
                    title: "VIP TIPS",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  ButtonTap(
                    title: "Vip",
                     color: Colors.white,
                    img: Icons.star,
                    imgg: Icons.star,
                  ),
                 SizedBox(
                height: 70.0,
              ),
              Container(
                height: 100,
                width: 600,
                child: AdmobBanner(
                  //adUnitId: getBannerAdUnitId(),
                  adUnitId: idAds.getBannerAdUnitId() ,
                  adSize: bannerSize,
                ),
              )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100,
        width: 600,
        child: AdmobBanner(
          adUnitId: idAds.getBannerAdUnitId(),
          adSize: bannerSize,
        ),
      ),
    );
  }
}
