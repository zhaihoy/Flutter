/** 数据结构
 * {
    "data": {
    "curPage": 2,
    "datas": [
    {
    "adminAdd": false,
    "apkLink": "",
    "audit": 1,
    "author": "",
    "canEdit": false,
    "chapterId": 502,
    "chapterName": "自助",
    "collect": false,
    "courseId": 13,
    "desc": "",
    "descMd": "",
    "envelopePic": "",
    "fresh": false,
    "host": "",
    "id": 28472,
    "isAdminAdd": false,
    "link": "https://juejin.cn/post/7372503361361100850",
    "niceDate": "2024-05-27 10:44",
    "niceShareDate": "2024-05-27 10:44",
    "origin": "",
    "prefix": "",
    "projectLink": "",
    "publishTime": 1716777878000,
    "realSuperChapterId": 493,
    "selfVisible": 0,
    "shareDate": 1716777878000,
    "shareUser": "linversion",
    "superChapterId": 494,
    "superChapterName": "广场Tab",
    "tags": [],
    "title": "安卓开发者在面试中应该怎么回答协程挂起的原理",
    "type": 0,
    "userId": 70466,
    "visible": 1,
    "zan": 0
    }
    ],
    "offset": 20,
    "over": false,
    "pageCount": 772,
    "size": 20,
    "total": 15440
    },
    "errorCode": 0,
    "errorMsg": ""
    }
 */
class PagePageResponseData {
  final PaginationData data;
  final int errorCode;
  final String errorMsg;

  PagePageResponseData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory PagePageResponseData.fromJson(Map<String, dynamic> json) {
    return PagePageResponseData(
      data: PaginationData.fromJson(json['data']),
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  static Future<PagePageResponseData> fromTopJson(
      Map<String, dynamic> jsonResponse) async {
    final data = PaginationData.fromTopJson(jsonResponse);
    final errorCode = jsonResponse['errorCode'];
    final errorMsg = jsonResponse['errorMsg'];
    return PagePageResponseData(
        data: data, errorCode: errorCode, errorMsg: errorMsg);
  }
}

class PaginationData {
  final int curPage;
  final List<Article> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  PaginationData({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory PaginationData.fromTopJson(Map<String, dynamic> json) {
    var articles = (json['data'] as List<dynamic>)
        .map((articleJson) => Article.fromJson(articleJson, true))
        .toList();
    return PaginationData(
      curPage: json['curPage'] ?? 0,
      datas: articles,
      offset: json['offset'] ?? 0,
      over: json['over'] ?? false,
      pageCount: json['pageCount'] ?? 0,
      size: json['size'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    var datasList = json['datas'] as List;
    List<Article> articles =
        datasList.map((item) => Article.fromJson(item, false)).toList();
    return PaginationData(
      curPage: json['curPage'],
      datas: articles,
      offset: json['offset'],
      over: json['over'],
      pageCount: json['pageCount'],
      size: json['size'],
      total: json['total'],
    );
  }
}

class Article {
  final bool adminAdd;
  final bool isTop;
  final String apkLink;
  final int audit;
  final String author;
  final bool canEdit;
  final int chapterId;
  final String chapterName;
  final bool collect;
  final int courseId;
  final String desc;
  final String descMd;
  final String envelopePic;
  final bool fresh;
  final String host;
  final int id;
  final bool isAdminAdd;
  final String link;
  final String niceDate;
  final String niceShareDate;
  final String origin;
  final String prefix;
  final String projectLink;
  final int publishTime;
  final int realSuperChapterId;
  final int selfVisible;
  final int shareDate;
  final String shareUser;
  final int superChapterId;
  final String superChapterName;
  final List<dynamic> tags; // 根据实际情况定义标签类型
  final String title;
  final int type;
  final int userId;
  final int visible;

  Article({
    required this.adminAdd,
    required this.apkLink,
    required this.audit,
    required this.author,
    required this.canEdit,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.desc,
    required this.descMd,
    required this.envelopePic,
    required this.fresh,
    required this.host,
    required this.id,
    required this.isAdminAdd,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.origin,
    required this.prefix,
    required this.projectLink,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.selfVisible,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.tags,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
    required this.isTop,
  });

  final int zan;

  factory Article.fromJson(Map<String, dynamic> json, bool top) {
    return Article(
      adminAdd: json['adminAdd'] ?? false,
      apkLink: json['apkLink'] ?? "",
      audit: json['audit'] ?? 0,
      author: json['author'] ?? "",
      canEdit: json['canEdit'] ?? false,
      chapterId: json['chapterId'] ?? 0,
      chapterName: json['chapterName'] ?? "",
      collect: json['collect'] ?? false,
      courseId: json['courseId'] ?? 0,
      desc: json['desc'] ?? "",
      descMd: json['descMd'] ?? "",
      envelopePic: json['envelopePic'] ?? "",
      fresh: json['fresh'] ?? false,
      host: json['host'] ?? "",
      id: json['id'] ?? 0,
      isAdminAdd: json['isAdminAdd'] ?? false,
      link: json['link'] ?? "",
      niceDate: json['niceDate'] ?? "",
      niceShareDate: json['niceShareDate'] ?? "",
      origin: json['origin'] ?? "",
      prefix: json['prefix'] ?? "",
      projectLink: json['projectLink'] ?? "",
      publishTime: json['publishTime'] ?? 0,
      realSuperChapterId: json['realSuperChapterId'] ?? 0,
      selfVisible: json['selfVisible'] ?? 0,
      shareDate: json['shareDate'] ?? 0,
      shareUser: json['shareUser'] ?? "",
      superChapterId: json['superChapterId'] ?? 0,
      superChapterName: json['superChapterName'] ?? "",
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => Tag.fromJson(tag))
          .toList() ??
          [],
      title: json['title'] ?? "",
      type: json['type'] ?? 0,
      userId: json['userId'] ?? 0,
      visible: json['visible'] ?? 0,
      zan: json['zan'] ?? 0,
      isTop: top,
    );
  }
}

// Define the Tag class
class Tag {
  final String name;
  final String url;

  Tag({required this.name, required this.url});

  // Factory constructor to create a Tag from JSON
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      url: json['url'],
    );
  }

  // Method to convert a Tag to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
