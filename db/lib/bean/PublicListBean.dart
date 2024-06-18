class PublicListBean {
  List<dynamic>? articleList;
  String? author;
  List<dynamic>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  PublicListBean({
    this.articleList,
    this.author,
    this.children,
    this.courseId,
    this.cover,
    this.desc,
    this.id,
    this.lisense,
    this.lisenseLink,
    this.name,
    this.order,
    this.parentChapterId,
    this.type,
    this.userControlSetTop,
    this.visible,
  });

  factory PublicListBean.fromJson(Map<String, dynamic> json) => PublicListBean(
    articleList: json['articleList'],
    author: json['author'],
    children: json['children'],
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

  Map<String, dynamic> toJson() => {
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
