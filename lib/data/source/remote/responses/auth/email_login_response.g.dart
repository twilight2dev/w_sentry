// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailLoginResponseData _$EmailLoginResponseDataFromJson(
        Map<String, dynamic> json) =>
    EmailLoginResponseData(
      id: json['id'] as String?,
      identifier: json['identifier'] as String?,
      email: json['email'] as String?,
      nickName: json['nickName'],
      status: json['status'] as String?,
      firstName: json['firstName'],
      lastName: json['lastName'] as String?,
      walletAddress: json['walletAddress'],
      birthday: json['birthday'] as int?,
      isAdmin: json['isAdmin'] as bool?,
      signedInAt: json['signedInAt'] as int?,
      signedUpAt: json['signedUpAt'] as int?,
      avatar: json['avatar'],
      state: json['state'],
      address: json['address'],
      verifiedAt: json['verifiedAt'] as int?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      isEnableTwoFactor: json['isEnableTwoFactor'] as bool?,
      role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
      provider: json['provider'],
      defaultAddress: json['defaultAddress'],
      idToken: json['idToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
