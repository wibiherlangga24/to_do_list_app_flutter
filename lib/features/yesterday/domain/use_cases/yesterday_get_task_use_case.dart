import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/yesterday/domain/repository/yesterday_repository.dart';

class YesterdayGetTaskUseCase {
  final YesterdayRepository _yesterdayRepository;

  const YesterdayGetTaskUseCase(this._yesterdayRepository);

  Future<List<TaskEntity>> call(String date) {
    return _yesterdayRepository.getSavedTasks(date);
  }
}
