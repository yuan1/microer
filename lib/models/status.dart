import 'package:microer/models/geo.dart';
import 'package:microer/models/user.dart';

class Status {
  String createdAt;
  int id;
  String text;
  String source;
  bool favorited;
  bool truncated;
  Geo geo;
  String mid;
  int repostsCount;
  int commentsCount;
  int attitudesCount;
  User user;

  Status.fromJsonMap(Map<String, dynamic> map)
      : createdAt = map["created_at"],
        id = map["id"],
        text = map["text"],
        source = map["source"],
        favorited = map["favorited"],
        truncated = map["truncated"],
        geo = map["geo"] == null ? null : Geo.fromJsonMap(map["geo"]),
        mid = map["mid"],
        repostsCount = map["reposts_count"],
        commentsCount = map["comments_count"],
        attitudesCount = map["attitudes_count"],
        user = map["user"] == null ? null : User.fromJsonMap(map["user"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = createdAt;
    data['id'] = id;
    data['text'] = text;
    data['source'] = source;
    data['favorited'] = favorited;
    data['truncated'] = truncated;
    data['geo'] = geo.toJson();
    data['mid'] = mid;
    data['reposts_count'] = repostsCount;
    data['comments_count'] = commentsCount;
    data['attitudes_count'] = attitudesCount;
    data['user'] = user.toJson();
    return data;
  }

  @override
  String toString() {
    return 'Status{createdAt: $createdAt, id: $id, text: $text, source: $source, favorited: $favorited, truncated: $truncated, geo: $geo, mid: $mid, repostsCount: $repostsCount, commentsCount: $commentsCount, attitudesCount: $attitudesCount, user: $user}';
  }
}

class Statuses {
  List<Status> statuses;
  int totalNumber;
  Statuses.fromJsonMap(Map<String, dynamic> map)
      : statuses = ((map['statuses'] as List)?.map((e)=>Status.fromJsonMap(e as Map<String, dynamic>))?.toList()),
        totalNumber = map["total_number"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuses'] = statuses.toString();
    data['total_number'] = totalNumber;
    return data;
  }

  @override
  String toString() {
    return 'Statuses{statuses: $statuses, totalNumber: $totalNumber}';
  }

}
