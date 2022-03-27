import 'dart:convert';

class User {
  String? name;
  String? mobileNumber;
  String? profileImage;
  String? documentId;

  User({this.name, this.mobileNumber,this.profileImage,this.documentId});

  User.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    documentId = json['documentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_image'] = profileImage;
    data['name'] = name;
    data['documentId'] = documentId;
    data['mobile_number'] = mobileNumber;
    return data;
  }

  static String encode(User data) => json.encode(data.toJson());

  static User decode(String data) => User.fromJson(json.decode(data));
}