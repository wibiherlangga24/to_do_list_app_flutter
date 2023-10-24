import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TaskRepository {
  // Database method
  Future<List<TaskEntity>> getSavedTasks();

  Future<void> saveTask(TaskEntity task);

  Future<void> removeTask(TaskEntity task);
}
