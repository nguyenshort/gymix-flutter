// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      hobby: json['hobby'] as String? ?? '',
      about: json['about'] as String? ?? '',
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'hobby': instance.hobby,
      'about': instance.about,
    };
