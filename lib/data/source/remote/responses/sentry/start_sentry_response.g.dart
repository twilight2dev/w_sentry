// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_sentry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartSentryResponseData _$StartSentryResponseDataFromJson(
        Map<String, dynamic> json) =>
    StartSentryResponseData(
      id: json['id'] as int?,
      repoId: json['repo_id'] as int?,
      trigger: json['trigger'] as String?,
      number: json['number'] as int?,
      status: json['status'] as String?,
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
    );
