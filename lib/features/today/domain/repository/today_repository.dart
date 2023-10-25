import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TodayRepository {
  // Database method
  Future<List<TaskEntity>> getSavedTasks(String date);
  Future<void> removeTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
}
