// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task()
  ..id = json['id'] as String?
  ..title = json['title'] as String?
  ..description = json['description'] as String?
  ..completedAt = json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String)
  ..createdAt = json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed_at': instance.completedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
