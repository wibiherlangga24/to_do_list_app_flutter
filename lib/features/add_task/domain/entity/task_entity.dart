import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? title;
  final String? dateTime;
  final String? description;

  const TaskEntity({this.id, this.title, this.dateTime, this.description});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dateTime,
        description,
      ];
}
