// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      name: json['name'] as String,
      level: json['level'] as String,
      content: json['content'] as String,
      avatar: json['avatar'] as String,
      composables: (json['composables'] as List<dynamic>)
          .map((e) => Composable.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
      'content': instance.content,
      'avatar': instance.avatar,
      'composables': instance.composables.map((e) => e.toJson()).toList(),
      'path': instance.path,
    };
