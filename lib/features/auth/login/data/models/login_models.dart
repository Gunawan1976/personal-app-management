// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/login_entities.dart';


LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends LoginEntities{
    final int? id;
    final String? username;
    final String? email;
    final String? firstName;
    final String? lastName;
    final String? gender;
    final String? image;
    final String? accessToken;
    final String? refreshToken;

    LoginModel({
        this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.gender,
        this.image,
        this.accessToken,
        this.refreshToken,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        image: json["image"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
