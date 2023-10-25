import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/today/domain/repository/today_repository.dart';

class GetTaskUseCase {
  final TodayRepository _todayRepository;

  const GetTaskUseCase(this._todayRepository);

  Future<List<TaskEntity>> call(String date) {
    return _todayRepository.getSavedTasks(date);
  }
}
