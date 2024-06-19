import 'PageResponseData.dart';

class ArticleResponse {
  late ArticleData data;
  int errorCode = 0;
  String errorMsg = "";

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    data = ArticleData.fromJson(json['data']);
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }
}

class ArticleData {
  int curPage = 0;
  List<Article> datas = [];
  int offset = 0;
  bool over = false;
  int pageCount = 0;
  int size = 0;
  int total = 0;

  ArticleData.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = List<Article>.from(
          json['datas'].map((item) => Article.fromJson(item, false)));
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
}