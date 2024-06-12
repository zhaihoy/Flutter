import 'package:db/weight/route/IRouterProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:db/page/HomePage.dart';

class HomeRouter implements IRouterProvide {
  static String homePage = '/home';

  @override
  void initRouter(FluroRouter router) {
    router.define(homePage,
        handler: Handler(handlerFunc: (_, __) => const HomePage()));
  }
}
