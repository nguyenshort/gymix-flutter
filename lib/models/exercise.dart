
import 'package:json_annotation/json_annotation.dart';

import 'composable.dart';

part 'exercise.g.dart';

@JsonSerializable(explicitToJson: true)
class Exercise {
  String name;
  String level;
  String content;
  String avatar;
  List<Composable> composables;

  String? path;

  Exercise({ required this.name, required this.level, required this.content, required this.avatar, required this.composables, this.path });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  int get count => composables.length;

}