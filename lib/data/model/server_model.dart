import 'package:json_annotation/json_annotation.dart';

part 'server_model.g.dart';

@JsonSerializable(createToJson: false)
class ServerModel {
  ServerModel({
    required this.id,
    required this.name,
    required this.url,
  });

  final String? id;
  final String? name;
  final String? url;

  @JsonKey(includeFromJson: false)
  bool isActive = false; 

  factory ServerModel.fromJson(Map<String, dynamic> json) => _$ServerModelFromJson(json);
}
