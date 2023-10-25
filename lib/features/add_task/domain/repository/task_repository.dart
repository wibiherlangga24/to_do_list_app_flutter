import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TaskRepository {
  Future<void> saveTask(TaskEntity task);
}
