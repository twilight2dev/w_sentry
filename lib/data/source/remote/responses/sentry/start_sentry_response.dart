import 'package:json_annotation/json_annotation.dart';

part 'start_sentry_response.g.dart';

@JsonSerializable(createToJson: false)
class StartSentryResponseData {
  StartSentryResponseData({
    required this.id,
    required this.repoId,
    required this.trigger,
    required this.number,
    required this.status,
    required this.event,
    required this.action,
    required this.link,
    required this.timestamp,
    required this.message,
    required this.before,
    required this.after,
    required this.ref,
    required this.sourceRepo,
    required this.source,
    required this.target,
    required this.authorLogin,
    required this.authorName,
    required this.authorEmail,
    required this.authorAvatar,
    required this.sender,
    required this.started,
    required this.finished,
    required this.created,
    required this.updated,
    required this.version,
  });

  final int? id;

  @JsonKey(name: 'repo_id')
  final int? repoId;
  final String? trigger;
  final int? number;
  final String? status;
  final String? event;
  final String? action;
  final String? link;
  final int? timestamp;
  final String? message;
  final String? before;
  final String? after;
  final String? ref;

  @JsonKey(name: 'source_repo')
  final String? sourceRepo;
  final String? source;
  final String? target;

  @JsonKey(name: 'author_login')
  final String? authorLogin;

  @JsonKey(name: 'author_name')
  final String? authorName;

  @JsonKey(name: 'author_email')
  final String? authorEmail;

  @JsonKey(name: 'author_avatar')
  final String? authorAvatar;
  final String? sender;
  final int? started;
  final int? finished;
  final int? created;
  final int? updated;
  final int? version;

  factory StartSentryResponseData.fromJson(Map<String, dynamic> json) => _$StartSentryResponseDataFromJson(json);
}
