import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import '../Constant/constant.dart';
import '../util/screen_utils.dart';
import 'ContainerPage.dart';

class SplashWeight extends StatefulWidget {
  const SplashWeight({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashWeight();
  }
}

class _SplashWeight extends State<StatefulWidget> {
  var container = const ContainerPage();

  bool showAd = true;

  //使用堆叠布局
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
    Offstage(
      offstage: showAd,
      child: container,
    ),
    Offstage(
    offstage:!showAd,
    child: Container(
      color: Colors.white,
      width: ScreenUtils.screenW(context),
      height: ScreenUtils.screenH(context),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: ScreenUtils.screenW(context) / 3,
                  backgroundColor: Colors.white,
                  backgroundImage:
                  const AssetImage(Constant.ASSETS_IMG + 'home.png'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    '落花有意随流水,流水无心恋落花',
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: const Alignment(1.0, 0.0),
                    child: Container(
                      margin: const EdgeInsets.only(right: 30.0, top: 20.0),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                      decoration: const BoxDecoration(
                          color: Color(0xffEDEDED),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      child: CountDownWidget(
                        onCountDownFinishCallBack: (bool value) {
                          if (value) {
                            setState(() {
                              showAd = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + 'ic_launcher.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Hi,豆芽',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    ),)
    ]
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;

  const CountDownWidget({super.key, @required this.onCountDownFinishCallBack});

  @override
  State<StatefulWidget> createState() {
    return _CountDownWidgetState();
  }
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 6;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: TextStyle(fontSize: 17.0),
    );
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
  }
}
