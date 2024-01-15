import 'package:json_annotation/json_annotation.dart';
import 'package:w_sentry/data/enum/drone_status.dart';

part 'get_job_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class GetJobDetailResponseData {
  GetJobDetailResponseData({
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
    required this.stages,
  });

  final int? id;

  @JsonKey(name: 'repo_id')
  final int? repoId;
  final String? trigger;
  final int? number;
  final DroneStatus? status;
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
  final List<JobStage>? stages;

  factory GetJobDetailResponseData.fromJson(Map<String, dynamic> json) => _$GetJobDetailResponseDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class JobStage {
  JobStage({
    required this.id,
    required this.repoId,
    required this.buildId,
    required this.number,
    required this.name,
    required this.kind,
    required this.type,
    required this.status,
    required this.errignore,
    required this.exitCode,
    required this.machine,
    required this.os,
    required this.arch,
    required this.started,
    required this.stopped,
    required this.created,
    required this.updated,
    required this.version,
    required this.onSuccess,
    required this.onFailure,
    required this.steps,
  });

  final int? id;

  @JsonKey(name: 'repo_id')
  final int? repoId;

  @JsonKey(name: 'build_id')
  final int? buildId;
  final int? number;
  final String? name;
  final String? kind;
  final String? type;
  final String? status;
  final bool? errignore;

  @JsonKey(name: 'exit_code')
  final int? exitCode;
  final String? machine;
  final String? os;
  final String? arch;
  final int? started;
  final int? stopped;
  final int? created;
  final int? updated;
  final int? version;

  @JsonKey(name: 'on_success')
  final bool? onSuccess;

  @JsonKey(name: 'on_failure')
  final bool? onFailure;
  final List<JobStep>? steps;

  factory JobStage.fromJson(Map<String, dynamic> json) => _$JobStageFromJson(json);
}

@JsonSerializable(createToJson: false)
class JobStep {
  JobStep({
    required this.id,
    required this.stepId,
    required this.number,
    required this.name,
    required this.status,
    required this.exitCode,
    required this.started,
    required this.stopped,
    required this.version,
  });

  final int? id;

  @JsonKey(name: 'step_id')
  final int? stepId;
  final int? number;
  final String? name;
  final String? status;

  @JsonKey(name: 'exit_code')
  final int? exitCode;
  final int? started;
  final int? stopped;
  final int? version;

  factory JobStep.fromJson(Map<String, dynamic> json) => _$JobStepFromJson(json);
}
