import 'package:equatable/equatable.dart';

class RefreshTokenEntities extends Equatable{
  final String? accessToken;
  final String? refreshToken;

  RefreshTokenEntities({
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];

}
