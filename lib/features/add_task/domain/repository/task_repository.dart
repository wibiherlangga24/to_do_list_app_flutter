import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getSavedTask(int id);
  Future<void> saveTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
}
