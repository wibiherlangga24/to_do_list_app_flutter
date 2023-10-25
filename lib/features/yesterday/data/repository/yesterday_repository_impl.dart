import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

import '../../domain/repository/yesterday_repository.dart';

class YesterdayRepositoryImpl extends YesterdayRepository {
  final AppDatabase _appDatabase;

  YesterdayRepositoryImpl(this._appDatabase);

  @override
  Future<List<TaskModel>> getSavedTasks(String date) async {
    return _appDatabase.taskDAO.getTasks(date);
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return _appDatabase.taskDAO.updateTask(TaskModel.fromEntity(task));
  }
}
