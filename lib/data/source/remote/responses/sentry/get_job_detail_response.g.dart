// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_job_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJobDetailResponseData _$GetJobDetailResponseDataFromJson(
        Map<String, dynamic> json) =>
    GetJobDetailResponseData(
      id: json['id'] as int?,
      repoId: json['repo_id'] as int?,
      trigger: json['trigger'] as String?,
      number: json['number'] as int?,
      status: $enumDecodeNullable(_$DroneStatusEnumMap, json['status']),
      event: json['event'] as String?,
      action: json['action'] as String?,
      link: json['link'] as String?,
      timestamp: json['timestamp'] as int?,
      message: json['message'] as String?,
      before: json['before'] as String?,
      after: json['after'] as String?,
      ref: json['ref'] as String?,
      sourceRepo: json['source_repo'] as String?,
      source: json['source'] as String?,
      target: json['target'] as String?,
      authorLogin: json['author_login'] as String?,
      authorName: json['author_name'] as String?,
      authorEmail: json['author_email'] as String?,
      authorAvatar: json['author_avatar'] as String?,
      sender: json['sender'] as String?,
      started: json['started'] as int?,
      finished: json['finished'] as int?,
      created: json['created'] as int?,
      updated: json['updated'] as int?,
      version: json['version'] as int?,
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => JobStage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$DroneStatusEnumMap = {
  DroneStatus.error: 'error',
  DroneStatus.failure: 'failure',
  DroneStatus.pending: 'pending',
  DroneStatus.success: 'success',
  DroneStatus.running: 'running',
};

JobStage _$JobStageFromJson(Map<String, dynamic> json) => JobStage(
      id: json['id'] as int?,
      repoId: json['repo_id'] as int?,
      buildId: json['build_id'] as int?,
      number: json['number'] as int?,
      name: json['name'] as String?,
      kind: json['kind'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      errignore: json['errignore'] as bool?,
      exitCode: json['exit_code'] as int?,
      machine: json['machine'] as String?,
      os: json['os'] as String?,
      arch: json['arch'] as String?,
      started: json['started'] as int?,
      stopped: json['stopped'] as int?,
      created: json['created'] as int?,
      updated: json['updated'] as int?,
      version: json['version'] as int?,
      onSuccess: json['on_success'] as bool?,
      onFailure: json['on_failure'] as bool?,
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => JobStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

JobStep _$JobStepFromJson(Map<String, dynamic> json) => JobStep(
      id: json['id'] as int?,
      stepId: json['step_id'] as int?,
      number: json['number'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      exitCode: json['exit_code'] as int?,
      started: json['started'] as int?,
      stopped: json['stopped'] as int?,
      version: json['version'] as int?,
    );
