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
  List<ArticleItem> datas = [];
  int offset = 0;
  bool over = false;
  int pageCount = 0;
  int size = 0;
  int total = 0;

  ArticleData.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = List<ArticleItem>.from(json['datas'].map((item) => ArticleItem.fromJson(item)));
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
}

class ArticleItem {
  bool adminAdd = false;
  String apkLink = "";
  int audit = 0;
  String author = "";
  bool canEdit = false;
  int chapterId = 0;
  String chapterName = "";
  bool collect = false;
  int courseId = 0;
  String desc = "";
  String descMd = "";
  String envelopePic = "";
  bool fresh = false;
  String host = "";
  int id = 0;
  bool isAdminAdd = false;
  String link = "";
  String niceDate = "";
  String niceShareDate = "";
  String origin = "";
  String prefix = "";
  String projectLink = "";
  int publishTime = 0;
  int realSuperChapterId = 0;
  int selfVisible = 0;
  int shareDate = 0;
  String shareUser = "";
  int superChapterId = 0;
  String superChapterName = "";
  List<ArticleTag> tags = [];
  String title = "";
  int type = 0;
  int userId = 0;
  int visible = 0;
  int zan = 0;

  ArticleItem.fromJson(Map<String, dynamic> json) {
    adminAdd = json['adminAdd'];
    apkLink = json['apkLink'];
    audit = json['audit'];
    author = json['author'];
    canEdit = json['canEdit'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    descMd = json['descMd'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    host = json['host'];
    id = json['id'];
    isAdminAdd = json['isAdminAdd'];
    link = json['link'];
    niceDate = json['niceDate'];
    niceShareDate = json['niceShareDate'];
    origin = json['origin'];
    prefix = json['prefix'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    realSuperChapterId = json['realSuperChapterId'];
    selfVisible = json['selfVisible'];
    shareDate = json['shareDate'];
    shareUser = json['shareUser'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    if (json['tags'] != null) {
      tags = List<ArticleTag>.from(json['tags'].map((item) => ArticleTag.fromJson(item)));
    }
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }
}

class ArticleTag {
  String name = "";
  String url = "";

  ArticleTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}