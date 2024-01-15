import 'package:json_annotation/json_annotation.dart';

part 'email_login_response.g.dart';

@JsonSerializable(createToJson: false)
class EmailLoginResponseData {
  EmailLoginResponseData({
    required this.id,
    required this.identifier,
    required this.email,
    required this.nickName,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.walletAddress,
    required this.birthday,
    required this.isAdmin,
    required this.signedInAt,
    required this.signedUpAt,
    required this.avatar,
    required this.state,
    required this.address,
    required this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isEnableTwoFactor,
    required this.role,
    required this.provider,
    required this.defaultAddress,
    required this.idToken,
    required this.refreshToken,
  });

  final String? id;
  final String? identifier;
  final String? email;
  final dynamic nickName;
  final String? status;
  final dynamic firstName;
  final String? lastName;
  final dynamic walletAddress;
  final int? birthday;
  final bool? isAdmin;
  final int? signedInAt;
  final int? signedUpAt;
  final dynamic avatar;
  final dynamic state;
  final dynamic address;
  final int? verifiedAt;
  final int? createdAt;
  final int? updatedAt;
  final bool? isEnableTwoFactor;
  final List<String>? role;
  final dynamic provider;
  final dynamic defaultAddress;
  final String? idToken;
  final String? refreshToken;

  factory EmailLoginResponseData.fromJson(Map<String, dynamic> json) => _$EmailLoginResponseDataFromJson(json);
}
