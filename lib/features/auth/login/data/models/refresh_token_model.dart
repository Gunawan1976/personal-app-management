// To parse this JSON data, do
//
//     final refreshTokenModel = refreshTokenModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/refresh_token_entities.dart';


RefreshTokenModel refreshTokenModelFromJson(String str) => RefreshTokenModel.fromJson(json.decode(str));

String refreshTokenModelToJson(RefreshTokenModel data) => json.encode(data.toJson());

class RefreshTokenModel extends RefreshTokenEntities{
  final String? accessToken;
  final String? refreshToken;

  RefreshTokenModel({
    this.accessToken,
    this.refreshToken,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
