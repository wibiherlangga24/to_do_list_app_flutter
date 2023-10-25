import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? title;
  final String? dateTime;
  final String? description;
  final int? status;

  const TaskEntity(
      {this.id, this.title, this.dateTime, this.description, this.status});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dateTime,
        description,
        status,
      ];

  TaskEntity copyWith({
    int? id,
    String? title,
    String? dateTime,
    String? description,
    int? status,
  }) {
    return TaskEntity(
      id: id,
      title: title,
      dateTime: dateTime,
      description: description,
      status: status,
    );
  }
}
