// Article.dart
class Article {
  final String title;
  final String author;
  final String link;
  final String niceDate;
  final int chapterId;
  final String chapterName;

  Article({
    required this.title,
    required this.author,
    required this.link,
    required this.niceDate,
    required this.chapterId,
    required this.chapterName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      author: json['author'],
      link: json['link'],
      niceDate: json['niceDate'],
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
    );
  }
}

// Chapter.dart
class Chapter {
  final int cid;
  final String name;
  final List<Article> articles;

  Chapter({
    required this.cid,
    required this.name,
    required this.articles,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var articlesJson = json['articles'] as List;
    List<Article> articlesList =
        articlesJson.map((i) => Article.fromJson(i)).toList();

    return Chapter(
      cid: json['cid'],
      name: json['name'],
      articles: articlesList,
    );
  }
}

// ResponseData.dart
class SysResponseData {
  final int errorCode;
  final String errorMsg;
  final List<Chapter> data;

  SysResponseData({
    required this.errorCode,
    required this.errorMsg,
    required this.data,
  });

  factory SysResponseData.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<Chapter> dataList = dataJson.map((i) => Chapter.fromJson(i)).toList();

    return SysResponseData(
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
      data: dataList,
    );
  }
}
