import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? title;
  final String? dateTime;
  final String? description;
  final int? status;
  final String? userId;

  const TaskEntity(
      {this.id,
      this.title,
      this.dateTime,
      this.description,
      this.status,
      this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dateTime,
        description,
        status,
        userId,
      ];

  TaskEntity copyWith({
    int? id,
    String? title,
    String? dateTime,
    String? description,
    int? status,
    String? userId,
  }) {
    return TaskEntity(
      id: id,
      title: title,
      dateTime: dateTime,
      description: description,
      status: status,
      userId: userId,
    );
  }
}
