import 'package:floor/floor.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

@Entity(tableName: 'task', primaryKeys: ['id'])
class TaskModel extends TaskEntity {
  const TaskModel({
    int? id,
    String? title,
    String? dateTime,
    String? description,
    int? status,
    String? userId,
  }) : super(
          id: id,
          title: title,
          dateTime: dateTime,
          description: description,
          status: status,
          userId: userId,
        );

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      dateTime: entity.dateTime,
      description: entity.description,
      status: entity.status,
      userId: entity.userId,
    );
  }
}
