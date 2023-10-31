import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

import '../../domain/repository/today_repository.dart';

class TodayRepositoryImpl extends TodayRepository {
  final AppDatabase _appDatabase;

  TodayRepositoryImpl(this._appDatabase);

  @override
  Future<List<TaskModel>> getSavedTasks(String date) async {
    final sharedPref = await SharedPreferences.getInstance();
    final emailUser = sharedPref.getString('email');
    return _appDatabase.taskDAO.getTasks(date, emailUser ?? '');
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
