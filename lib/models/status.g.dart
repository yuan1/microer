// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status()
    ..created_at = json['created_at'] as String
    ..id = json['id'] as num
    ..text = json['text'] as String
    ..source = json['source'] as String
    ..favorited = json['favorited'] as bool
    ..truncated = json['truncated'] as bool
    ..in_reply_to_status_id = json['in_reply_to_status_id'] as String
    ..in_reply_to_user_id = json['in_reply_to_user_id'] as String
    ..in_reply_to_screen_name = json['in_reply_to_screen_name'] as String
    ..geo = json['geo'] as String
    ..mid = json['mid'] as String
    ..annotations = json['annotations'] as List
    ..reposts_count = json['reposts_count'] as num
    ..comments_count = json['comments_count'] as num;
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'created_at': instance.created_at,
      'id': instance.id,
      'text': instance.text,
      'source': instance.source,
      'favorited': instance.favorited,
      'truncated': instance.truncated,
      'in_reply_to_status_id': instance.in_reply_to_status_id,
      'in_reply_to_user_id': instance.in_reply_to_user_id,
      'in_reply_to_screen_name': instance.in_reply_to_screen_name,
      'geo': instance.geo,
      'mid': instance.mid,
      'annotations': instance.annotations,
      'reposts_count': instance.reposts_count,
      'comments_count': instance.comments_count
    };
