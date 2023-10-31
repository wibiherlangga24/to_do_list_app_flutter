import 'package:floor/floor.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';

@dao
abstract class TaskDao {
  @Insert()
  Future<void> insertTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);

  @Query('SELECT * FROM task WHERE dateTime = :date AND userId = :email')
  Future<List<TaskModel>> getTasks(String date, String email);

  @Query('SELECT * FROM task WHERE id = :id')
  Future<List<TaskModel>> getTasksById(int id);

  @update
  Future<void> updateTask(TaskModel task);
}
