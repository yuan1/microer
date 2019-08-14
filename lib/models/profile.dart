import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'profile.g.dart';
@JsonSerializable()
class Profile {
Profile();

User user;
    String token;
    String code;
    String uid;
    num theme;
    
factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
Map<String, dynamic> toJson() => _$ProfileToJson(this);
}