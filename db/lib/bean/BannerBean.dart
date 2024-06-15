class BannerBean {
    String desc;
    int id;
    String imagePath;
    int isVisible;
    int order;
    String title;
    int type;
    String url;

    BannerBean({
        required this.desc,
        required this.id,
        required this.imagePath,
        required this.isVisible,
        required this.order,
        required this.title,
        required this.type,
        required this.url,
    });

    factory BannerBean.fromJson(Map<String, dynamic> json) {
        return BannerBean(
            desc: json['desc'] as String,
            id: json['id'] as int,
            imagePath: json['imagePath'] as String,
            isVisible: json['isVisible'] as int,
            order: json['order'] as int,
            title: json['title'] as String,
            type: json['type'] as int,
            url: json['url'] as String,
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'desc': desc,
            'id': id,
            'imagePath': imagePath,
            'isVisible': isVisible,
            'order': order,
            'title': title,
            'type': type,
            'url': url,
        };
    }
}
