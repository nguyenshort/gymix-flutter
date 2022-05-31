import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  String name;
  String address;
  String hobby;
  String about;

  UserData({ this.name = '', this.address = '', this.hobby = '', this.about = '' });


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}