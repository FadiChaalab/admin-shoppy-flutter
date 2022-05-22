class UserModel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? addrese;
  final int? phone;
  final int? age;
  final String? avatarUrl;

  UserModel({
    required this.uid,
    this.firstName,
    this.lastName,
    required this.email,
    this.addrese,
    this.phone,
    this.age,
    this.avatarUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        email = json["email"],
        addrese = json["addrese"],
        phone = json["phone"],
        age = json["age"],
        // ignore: prefer_if_null_operators
        avatarUrl = json["avatarUrl"] == null ? null : json["avatarUrl"];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'addrese': addrese,
      'phone': phone,
      'age': age,
      // ignore: prefer_if_null_operators
      'avatarUrl': avatarUrl == null ? null : avatarUrl,
    };
  }
}
