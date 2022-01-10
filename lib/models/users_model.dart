// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
    UsersModel({
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
        required this.users,
        required this.support,
    });

    int page;
    int perPage;
    int total;
    int totalPages;
    List<User> users;
    Support support;

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        users: List<User>.from(json["data"].map((x) => User.fromJson(x))),
        support: Support.fromJson(json["support"]),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(users.map((x) => x.toJson())),
        "support": support.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.avatar,
    });

    int id;
    String email;
    String firstName;
    String lastName;
    String avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
    };

  @override
  String toString() {
    String result = "First Name: $firstName \n";
    result += "Last Name: $lastName\n";
    return result;
  }


}

class Support {
    Support({
        required this.url,
        required this.text,
    });

    String url;
    String text;

    factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
    };
}
