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

  ArticleData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      curPage = json['curPage'] ?? 0;
      if (json['datas'] != null) {
        datas = List<Article>.from(
          json['datas'].map((item) => Article.fromJson(item, false)),
        );
      }
      offset = json['offset'] ?? 0;
      over = json['over'] ?? false;
      pageCount = json['pageCount'] ?? 0;
      size = json['size'] ?? 0;
      total = json['total'] ?? 0;
    } else {
      // Handle case where json is null (if needed)
    }
  }
}
