// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..mother = json['mother'] == null
        ? null
        : Person.fromJson(json['mother'] as Map<String, dynamic>)
    ..friends = (json['friends'] as List)
        ?.map((e) =>
            e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mother': instance.mother,
      'friends': instance.friends
    };
