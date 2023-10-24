import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final AppDatabase _appDatabase;

  TaskRepositoryImpl(this._appDatabase);

  @override
  Future<List<TaskModel>> getSavedTasks() async {
    return _appDatabase.taskDAO.getTasks();
  }

  @override
  Future<void> removeTask(TaskEntity task) {
    return _appDatabase.taskDAO.deleteTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> saveTask(TaskEntity task) {
    return _appDatabase.taskDAO.insertTask(TaskModel.fromEntity(task));
  }
}
