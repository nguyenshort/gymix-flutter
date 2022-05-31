// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Composable _$ComposableFromJson(Map<String, dynamic> json) => Composable(
      name: json['name'] as String,
      content: json['content'] as String,
      avatar: json['avatar'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$ComposableToJson(Composable instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
      'avatar': instance.avatar,
      'time': instance.time,
    };
