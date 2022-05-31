import 'package:json_annotation/json_annotation.dart';

part 'composable.g.dart';

@JsonSerializable()
class Composable {
  String name;
  String content;
  String avatar;
  String time;

  Composable({ required this.name, required this.content, required this.avatar, required this.time });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Composable.fromJson(Map<String, dynamic> json) => _$ComposableFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ComposableToJson(this);
}