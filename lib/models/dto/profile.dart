/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
import 'dart:convert';

class Profile {
  String? id;
  String? name;
  String? surname;
  String? role;
  String? email;
  String? photo;

  Profile(
      {
      this.id,
      this.name,
      this.surname,
      this.role,
      this.email,
      this.photo});

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory Profile.fromRawJson(String str) => Profile.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory Profile.fromMap(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      role: json['role'],
      email: json['email'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['role'] = role;
    data['email'] = email;
    data['photo'] = photo;
    return data;
  }
}
