class Chapter {
  List<dynamic> articleList;
  String author;
  late List<Chapter> children;
  int courseId;
  String cover;
  String desc;
  int id;
  String lisense;
  String lisenseLink;
  String name;
  int order;
  int parentChapterId;
  int type;
  bool userControlSetTop;
  int visible;

  Chapter({
    required this.articleList,
    required this.author,
    required this.children,
    required this.courseId,
    required this.cover,
    required this.desc,
    required this.id,
    required this.lisense,
    required this.lisenseLink,
    required this.name,
    required this.order,
    required this.parentChapterId,
    required this.type,
    required this.userControlSetTop,
    required this.visible,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      articleList: json['articleList'],
      author: json['author'],
      children: List<Chapter>.from((json['children'] ?? []).map((x) => Chapter.fromJson(x))),
      courseId: json['courseId'],
      cover: json['cover'],
      desc: json['desc'],
      id: json['id'],
      lisense: json['lisense'],
      lisenseLink: json['lisenseLink'],
      name: json['name'],
      order: json['order'],
      parentChapterId: json['parentChapterId'],
      type: json['type'],
      userControlSetTop: json['userControlSetTop'],
      visible: json['visible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleList': articleList,
      'author': author,
      'children': List<dynamic>.from(children.map((x) => x.toJson())),
      'courseId': courseId,
      'cover': cover,
      'desc': desc,
      'id': id,
      'lisense': lisense,
      'lisenseLink': lisenseLink,
      'name': name,
      'order': order,
      'parentChapterId': parentChapterId,
      'type': type,
      'userControlSetTop': userControlSetTop,
      'visible': visible,
    };
  }
}

class ChapterResponse {
  late List<Chapter> data;
  late int errorCode;
  late String errorMsg;

  ChapterResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ChapterResponse.fromJson(Map<String, dynamic> json) {
    return ChapterResponse(
      data: List<Chapter>.from((json['data'] ?? []).map((x) => Chapter.fromJson(x))),
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}
