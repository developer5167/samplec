import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:samplec/SharedPref.dart';
import 'package:samplec/mobile/model/MyData.dart';
import '../AdHelper.dart';
import '../SocketConnection.dart';
import '../colors.dart';
import '../constants.dart';
import '../styles.dart';
import 'chatScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var moveOnlineStatus = false;
  var loadingVisibility = false;
  RewardedAd? _rewardedAd;
  late MyData loginResponseData;
  bool selectedPreferenceMale = false;
  bool selectedPreferenceFemale = false;
  bool selectedPreferenceRandom = false;
  var cancelButton = false;
  var name = "";
  var userOnlineStatus = false;
  var onlineButton = true;
  int _start = 2;
  String preferenceValue = "";
  late Timer _timer;
  late IO.Socket socket;
  int allowOnlyOnceToChatRoom = 0;
  BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (Ad a) {
        print("cdSKCSDKCds");
      }, onAdFailedToLoad: (Ad ad, LoadAdError err) {
        print("cdSKCSDKCds ad opened ${err.responseInfo}");
        ad.dispose();
      }, onAdOpened: (Ad ad) {
        print("cdSKCSDKCds ad opened");
      }),
      request: const AdRequest());

  @override
  void initState() {
    _loadRewardedAd();
    initLoginData();
    socket = SocketConnection.getSocket()!;
    socket.connect();
    socket.onConnect((_) {
      print('Connected');
    });
    socket.onDisconnect((_) {
      print('Disconnected');
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void connectToServer(BuildContext context) async {
    socket.emit("readyToPair", jsonEncode(loginResponseData));
    socket.on("pair", (data) {
      if (allowOnlyOnceToChatRoom == 0) {
        Map<String, dynamic> decodedJson = jsonDecode(data);
        _navigateAndDisplaySelection(context, decodedJson);
        allowOnlyOnceToChatRoom++;
      }
    });
    socket.on("waiting", (data) {
      Constants.showSnackBar(context, data);
    });
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context, Map<String, dynamic> decodedJson) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    vibrate();
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(pairedUser: decodedJson)));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;
    if (result == null) {
      setState(() {
        initLoginData();
        moveOnlineStatus = false;
        onlineButton = true;
        userOnlineStatus = false;
        cancelButton = false;
        allowOnlyOnceToChatRoom = 0;
        _start = 3;
        loadingVisibility = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 50,
          child: AdWidget(
            ad: bannerAd..load(),
          ),
        ),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (userOnlineStatus) {
                _showAlertDialog(context);
              } else {
                socket.disconnect();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                "assets/images/back.png",
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome! ",
                            style: GoogleFonts.poppins(

                              textStyle: const TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w800,),
                            ),
                          ),
                          TextSpan(
                            text: name,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: pinkColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "we are very happy to see you here, we are ready to connect you to a random user, please click on the below button",
                        style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 12, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: onlineButton,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              vibrate();
                              setState(() {
                                moveOnlineStatus = true;
                                cancelButton = true;
                                onlineButton = false;
                                _startTimer(context);
                                // moveToOnline();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 80,
                              height: 80,
                              child: Center(
                                  child: Text(
                                textAlign: TextAlign.center,
                                "Go\nonline",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: whiteColor)),
                              )),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: moveOnlineStatus,
                  child: Column(
                    children: [
                      Text(
                        "Moving to online in $_start seconds",
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            cancel();
                          },
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(decoration: TextDecoration.underline, color: pinkColor, decorationColor: pinkColor)),
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: loadingVisibility,
                  child: Lottie.asset('assets/images/searching.json', width: 100, height: 100),
                ),
                Visibility(
                  visible: onlineButton,
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        openDropDown();
                      },
                      child: Text(
                        "Click here to set preference",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: blackColor, decoration: TextDecoration.underline),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Note:Please remember to engage respectfully and be mindful of privacy boundaries when chatting. Report any inappropriate behaviour, and review our Terms of Service for guidance.",
                    style: GoogleFonts.poppins(textStyle: const TextStyle(color: blackColor), fontSize: 11, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void moveToOnline(BuildContext context) async {
    setState(() {
      loadingVisibility = true;
      moveOnlineStatus = false;
    });
    userOnlineStatus = true;
    connectToServer(context);
  }

  void cancel() {
    _timer.cancel();
    _start = 2;
    setState(() {
      moveOnlineStatus = false;
      onlineButton = true;
      cancelButton = false;
      loadingVisibility = false;
    });
  }

  void _startTimer(BuildContext context) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            moveToOnline(context);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Go offline?'),
        content: const Text('Are you sure,you want to go offline?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              vibrate();
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            // This parameter indicates the action would perform
            // a destructive action such as deletion, and turns
            // the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              vibrate();
              socket.off("pair");
              setState(() {
                moveOnlineStatus = false;
                onlineButton = true;
                cancelButton = false;
                userOnlineStatus=false;
                loadingVisibility = false;
                _start = 2;
              });
              // removeFromOnline();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void initLoginData() async {
    MobileAds.instance.initialize();
    SharedPref sharedPref = SharedPref();
    loginResponseData = MyData.fromJson(await sharedPref.read("user"));
    loginResponseData.interestedIn = "auto";
    setState(() {
      name = loginResponseData.name!;
    });
  }

  void openDropDown() {
    showModalBottomSheet(
        enableDrag: false,
        useSafeArea: true,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: StatefulBuilder(builder: (context, state) {
              return dropDownsheet(state, context);
            }),
          );
        });
  }

  Widget dropDownsheet(StateSetter state, context) {
    return Container(
      decoration:
          const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Preferences:",
                  style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    state(() {
                      selectedPreferenceMale = true;
                      selectedPreferenceFemale = false;
                      selectedPreferenceRandom = false;
                      startAd("Male");
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Male",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(),
                      Row(
                        children: [
                          Text(
                            " (watch ad)",
                            style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
                            textAlign: TextAlign.start,
                          ),
                          Visibility(
                              visible: selectedPreferenceMale,
                              child: const Icon(
                                Icons.check,
                                color: Colors.green,
                              )),
                        ],
                      ),
                    ],
                  ),
                )),
            Divider(),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    state(() {
                      selectedPreferenceMale = false;
                      selectedPreferenceFemale = true;
                      selectedPreferenceRandom = false;
                    });
                    startAd("Female");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Female",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      Container(),
                      Row(
                        children: [
                          Text(
                            " (watch ad)",
                            style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
                            textAlign: TextAlign.start,
                          ),
                          Visibility(
                              visible: selectedPreferenceFemale,
                              child: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ))
                        ],
                      ),
                    ],
                  ),
                )),
            Divider(),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    state(() {
                      loginResponseData.interestedIn = "auto";
                      selectedPreferenceMale = false;
                      selectedPreferenceFemale = false;
                      selectedPreferenceRandom = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Random",
                          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      Container(),
                      Visibility(
                          visible: selectedPreferenceRandom,
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void startAd(String s) {
    loginResponseData.interestedIn = s;
    _rewardedAd?.show(
      onUserEarnedReward: (_, reward) {
        loginResponseData.interestedIn = s;
        _loadRewardedAd();
      },
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }
}
