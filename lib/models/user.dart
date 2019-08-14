import 'package:json_annotation/json_annotation.dart';
import "status.dart";
part 'user.g.dart';
@JsonSerializable()
class User {
User();

num id;
    String screen_name;
    String name;
    String province;
    String city;
    String location;
    String description;
    String url;
    String profile_image_url;
    String domain;
    String gender;
    num followers_count;
    num friends_count;
    num statuses_count;
    num favourites_count;
    String created_at;
    bool following;
    bool allow_all_act_msg;
    bool geo_enabled;
    bool verified;
    Status status;
    bool allow_all_comment;
    String avatar_large;
    String verified_reason;
    bool follow_me;
    num online_status;
    num bi_followers_count;
    
factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
Map<String, dynamic> toJson() => _$UserToJson(this);
}