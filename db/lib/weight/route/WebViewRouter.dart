import 'package:db/weight/route/IRouterProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';

import '../../page/WebViewPage.dart';
import 'ARoute.dart';

class WebViewRouter implements IRouterProvide {
  @override
  void initRouter(FluroRouter router) {
    router.define(ARoute.webViewPage,
        handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));
  }
}
