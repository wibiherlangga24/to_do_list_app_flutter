import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class YesterdayRepository {
  // Database method
  Future<List<TaskEntity>> getSavedTasks(String date);
  Future<void> updateTask(TaskEntity task);
}
