import 'package:json_annotation/json_annotation.dart';

part 'todo_list_dto.g.dart'; // Point to the part file

@JsonSerializable()
class TodoListDto {
  final int id;
  final String title;
  final String description;
  final bool completed;

  TodoListDto({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory TodoListDto.fromJson(Map<String, dynamic> json) => _$TodoListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListDtoToJson(this);
}
