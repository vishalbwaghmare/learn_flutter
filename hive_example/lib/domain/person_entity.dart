class PersonEntity{
  String? name;
  String? nickName;

  PersonEntity({
    required this.name,
    required this.nickName,
  });


  factory PersonEntity.fromJson(Map<String, String>? json){
    return PersonEntity(
      name: json?['name'] ?? "",
      nickName: json?['nickName'] ?? "",
    );
  }

  Map<String, String> toJson()=> {
    "name": name ?? "",
    "nickName": nickName ?? ""
  };
}