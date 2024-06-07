import 'package:flutter/material.dart';
import 'dart:async';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Image.asset("assets/images/splash_logo.png"),
                    ),
                    // 第三个小部件（位于第二个小部件之上）
                    const Positioned(
                        top: 50, right: 50, child: CountDownWidget()),
                  ],
                ))));
  }
}

//封装一个倒计时的组件
class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CountDownStatefulWidget();
  }
}

/**
 * 在 Flutter 中，一个小部件（Widget）的生命周期主要由两个类来管理：StatefulWidget 和 StatelessWidget。下面是它们各自的生命周期方法：

    StatefulWidget 的生命周期方法
    createState:

    当 StatefulWidget 首次插入到 Widget 树中时调用，用于创建与该小部件关联的状态对象。
    initState:

    在状态对象被插入到 Widget 树时调用，用于初始化状态。
    didChangeDependencies:

    在 initState 之后立即调用，当小部件依赖的对象发生变化时调用，可以用于初始化依赖的对象。
    didUpdateWidget:

    在小部件的配置发生变化时调用，例如父小部件传入新的值时。
    build:

    构建小部件的 UI，每次状态发生变化时都会调用。
    setState:

    用于通知 Flutter 框架，小部件的状态已经发生了变化，需要重新构建 UI。
    deactivate:

    当小部件被移除时调用，可以在这里释放资源，但是小部件的状态对象不会被销毁。
    dispose:

    当小部件被永久删除时调用，用于释放资源，例如取消定时器、关闭流等。
    StatelessWidget 的生命周期方法
    build:
    构建小部件的 UI，每次状态发生变化时都会调用。
    StatelessWidget 没有其他的生命周期方法，因为它的状态是不可变的，只有在构建时传入的参数变化时才会重新构建 UI。

    这些是 Flutter 中 StatefulWidget 和 StatelessWidget 的生命周期方法。每个方法在小部件的不同生命周期阶段都会被调用，允许您在这些阶段执行必要的操作。
 */
class _CountDownStatefulWidget extends State<StatefulWidget> {
  var _seconds = 6;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          width: 50,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                print("you jump i jump");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Center(
                  child: Text(
                '跳过$_seconds' "s",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ))),
        ),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        print("zhy"+'$_seconds');
      });
      if (_seconds <= 1) {
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer.cancel();
    print("i Want Jump");
  }
}
