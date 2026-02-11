
import 'package:hive/hive.dart';
part 'person.g.dart';

@HiveType(typeId: 1)
class Person{
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? nickName;

  Person({
    required this.name,
    required this.nickName,
});


  factory Person.fromJson(Map<String, String>? json){
    return Person(
        name: json?['name'] ?? "",
        nickName: json?['nickName'] ?? "",
    );
  }

  Map<String, String> toJson()=> {
    "name": name ?? "",
    "nickName": nickName ?? ""
  };
}