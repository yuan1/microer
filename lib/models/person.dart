import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';
@JsonSerializable()
class Person {
Person();

num id;
    String name;
    String email;
    Person mother;
    List<Person> friends;
    
factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);
Map<String, dynamic> toJson() => _$PersonToJson(this);
}