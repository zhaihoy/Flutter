import 'package:db/page/HomePage.dart';
import 'package:db/weight/route/HomeRouter.dart';
import 'package:db/weight/route/IRouterProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter/cupertino.dart';
import '../../page/NotPage.dart';

class ARoute {
  static String home = '/home';
  static String webViewPage = '/webView';
  static final List<IRouterProvide> _listRouter = [];
  static final FluroRouter router = FluroRouter();

  //初始化路由集合
  static  initARoute() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print('未找到目标页');
      return const NotPage();
    });

    // router.define(home,
    //     handler: Handler(
    //         handlerFunc:
    //             (BuildContext? context, Map<String, List<String>> params) =>
    //                 const HomePage()));

    // router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
    //   final String title = params['title']?.first ?? '';
    //   final String url = params['url']?.first ?? '';
    //   return WebViewPage(title: title, url: url);
    // }));

    _listRouter.clear();
    _listRouter.add(HomeRouter());

    void initRouter(IRouterProvide routerProvide) {
      print("zhy^_^ 注册");
      routerProvide.initRouter(router);
    }

    _listRouter.forEach(initRouter);
  }
}
