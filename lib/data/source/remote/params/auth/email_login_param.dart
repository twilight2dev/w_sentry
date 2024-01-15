import 'package:json_annotation/json_annotation.dart';

part 'email_login_param.g.dart';

@JsonSerializable()
class EmailLoginParam {
  EmailLoginParam({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory EmailLoginParam.fromJson(Map<String, dynamic> json) => _$EmailLoginParamFromJson(json);

  get username => null;

  Map<String, dynamic> toJson() => _$EmailLoginParamToJson(this);
}
