import 'package:db/weight/route/ARoute.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

///  定义类路由跳转类
class Fluroutils {
  static void navigateTo(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    ARoute.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native,
        routeSettings: RouteSettings(arguments: arguments));
  }

  static void navigateToResult(
      BuildContext context, String path, void Function(Object) function,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    ARoute.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native,
            routeSettings: RouteSettings(arguments: arguments))
        .then((Object? result) {
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((onError) {
      function(onError);
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
