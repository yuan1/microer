// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as num
    ..screen_name = json['screen_name'] as String
    ..name = json['name'] as String
    ..province = json['province'] as String
    ..city = json['city'] as String
    ..location = json['location'] as String
    ..description = json['description'] as String
    ..url = json['url'] as String
    ..profile_image_url = json['profile_image_url'] as String
    ..domain = json['domain'] as String
    ..gender = json['gender'] as String
    ..followers_count = json['followers_count'] as num
    ..friends_count = json['friends_count'] as num
    ..statuses_count = json['statuses_count'] as num
    ..favourites_count = json['favourites_count'] as num
    ..created_at = json['created_at'] as String
    ..following = json['following'] as bool
    ..allow_all_act_msg = json['allow_all_act_msg'] as bool
    ..geo_enabled = json['geo_enabled'] as bool
    ..verified = json['verified'] as bool
    ..status = json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>)
    ..allow_all_comment = json['allow_all_comment'] as bool
    ..avatar_large = json['avatar_large'] as String
    ..verified_reason = json['verified_reason'] as String
    ..follow_me = json['follow_me'] as bool
    ..online_status = json['online_status'] as num
    ..bi_followers_count = json['bi_followers_count'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'screen_name': instance.screen_name,
      'name': instance.name,
      'province': instance.province,
      'city': instance.city,
      'location': instance.location,
      'description': instance.description,
      'url': instance.url,
      'profile_image_url': instance.profile_image_url,
      'domain': instance.domain,
      'gender': instance.gender,
      'followers_count': instance.followers_count,
      'friends_count': instance.friends_count,
      'statuses_count': instance.statuses_count,
      'favourites_count': instance.favourites_count,
      'created_at': instance.created_at,
      'following': instance.following,
      'allow_all_act_msg': instance.allow_all_act_msg,
      'geo_enabled': instance.geo_enabled,
      'verified': instance.verified,
      'status': instance.status,
      'allow_all_comment': instance.allow_all_comment,
      'avatar_large': instance.avatar_large,
      'verified_reason': instance.verified_reason,
      'follow_me': instance.follow_me,
      'online_status': instance.online_status,
      'bi_followers_count': instance.bi_followers_count
    };
