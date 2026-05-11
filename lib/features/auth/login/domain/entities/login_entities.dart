import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? accessToken;
  final String? refreshToken;

  LoginEntities({
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

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstName,
    lastName,
    gender,
    image,
    accessToken,
    refreshToken,
  ];



}
