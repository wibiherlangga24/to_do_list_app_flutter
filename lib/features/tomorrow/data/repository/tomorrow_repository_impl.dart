import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

import '../../domain/repository/tomorrow_repository.dart';

class TomorrowRepositoryImpl extends TomorrowRepository {
  final AppDatabase _appDatabase;

  TomorrowRepositoryImpl(this._appDatabase);

  @override
  Future<List<TaskModel>> getSavedTasks(String date) async {
    return _appDatabase.taskDAO.getTasks(date);
  }

  @override
  Future<void> removeTask(TaskEntity task) {
    return _appDatabase.taskDAO.deleteTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return _appDatabase.taskDAO.updateTask(TaskModel.fromEntity(task));
  }
}
