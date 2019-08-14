import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';
@JsonSerializable()
class Status {
Status();

String created_at;
    num id;
    String text;
    String source;
    bool favorited;
    bool truncated;
    String in_reply_to_status_id;
    String in_reply_to_user_id;
    String in_reply_to_screen_name;
    String geo;
    String mid;
    List annotations;
    num reposts_count;
    num comments_count;
    
factory Status.fromJson(Map<String,dynamic> json) => _$StatusFromJson(json);
Map<String, dynamic> toJson() => _$StatusToJson(this);
}