class Chapter {
  List<dynamic> articleList;
  String author;
  List<dynamic> children;
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
      children: json['children'].map((e) => Chapter.fromJson(e)).toList(),
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
      'children': children,
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
  List<Chapter> data;
  int errorCode;
  String errorMsg;

  ChapterResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ChapterResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Chapter> chapters = dataList.map((e) => Chapter.fromJson(e)).toList();

    return ChapterResponse(
      data: chapters,
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((chapter) => chapter.toJson()).toList(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}
