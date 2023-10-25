import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/tomorrow/domain/repository/tomorrow_repository.dart';

class TomorrowGetTaskUseCase {
  final TomorrowRepository _tomorrowRepository;

  const TomorrowGetTaskUseCase(this._tomorrowRepository);

  Future<List<TaskEntity>> call(String date) {
    return _tomorrowRepository.getSavedTasks(date);
  }
}
