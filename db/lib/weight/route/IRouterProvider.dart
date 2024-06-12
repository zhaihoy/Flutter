import 'package:fluro/fluro.dart';

interface class IRouterProvide {
  void initRouter(FluroRouter router) {
    //一定要注意这FluroRouter 对象  往这个FluroRouter注册就要去这个FluroRouter对象里取
  }
}
