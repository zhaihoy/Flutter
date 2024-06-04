class SubjectEntity {
//  "subject":Object{...},
//  "rank":1,
//  "delta":0

  late Subject subject;
  var rank;
  var delta;

  fromMap(Map<String, dynamic> map) {
    rank = map['rank'];
    delta = map['delta'];
    var subjectMap = map['subject'];
    subject = Subject.fromMap(subjectMap);
  }
}

class Subject {
  bool tag = false;
  late Rating rating;
  late List<dynamic> genres;
  late String title;
  late List<Cast> casts;
  late List<dynamic> durations;
  late int collectCount;
  late String mainlandPubdate;
  late bool hasVideo;
  late String originalTitle;
  late String subtype;
  late List<dynamic> directors;
  late List<dynamic> pubdates;
  late String year;
  late Images images;
  late String alt;
  late String id;

  Subject({
    required this.tag,
    required this.rating,
    required this.genres,
    required this.title,
    required this.casts,
    required this.durations,
    required this.collectCount,
    required this.mainlandPubdate,
    required this.hasVideo,
    required this.originalTitle,
    required this.subtype,
    required this.directors,
    required this.pubdates,
    required this.year,
    required this.images,
    required this.alt,
    required this.id,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    var ratingMap = map['rating'];
    var imgMap = map['images'];
    var castList = map['casts'];

    return Subject(
      tag: false,
      // Provide a default value or initialize elsewhere
      rating: Rating(ratingMap['average'], ratingMap['max']),
      genres: map['genres'],
      title: map['title'],
      casts: _convertCasts(castList),
      collectCount: map['collect_count'],
      originalTitle: map['original_title'],
      subtype: map['subtype'],
      directors: map['directors'],
      year: map['year'],
      images: Images(imgMap['small'], imgMap['large'], imgMap['medium']),
      alt: map['alt'],
      id: map['id'],
      durations: map['durations']??[],
      mainlandPubdate: map['mainland_pubdate']??"",
      hasVideo: map['has_video']??false,
      pubdates: map['pubdates']??[],
    );
  }

  static List<Cast> _convertCasts(List<dynamic> castList) {
    return castList.map<Cast>((item) => Cast.fromMap(item)).toList();
  }
}

class Images {
  var small;
  var large;
  var medium;

  Images(this.small, this.large, this.medium);
}

class Rating {
  var average;
  var max;

  Rating(this.average, this.max);
}

class Cast {
  late String id;
  late String nameEn;
  late String name;
  late Avatar avatars;
  late String alt;

  Cast(this.avatars, this.nameEn, this.name, this.alt, this.id);

  factory Cast.fromMap(Map<String, dynamic> map) {
    print("id>>> "+map['id'].toString());
    var tmp = map['avatars'];
    return Cast(
      Avatar(
        tmp != null ? tmp['small'] : '',
        tmp != null ? tmp['large'] : '',
        tmp != null ? tmp['medium'] : '',
      ),
      map['name_en'] ?? "",
      map['name']?? "",
      map['alt']?? "",
      map['id']?? "",
    );
  }
}

class Avatar {
  late String medium;
  late String large;
  late String small;

  Avatar(this.small, this.large, this.medium);
}
