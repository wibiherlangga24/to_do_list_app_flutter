import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/today/domain/repository/today_repository.dart';

class UpdateTaskUseCase {
  final TodayRepository _todayRepository;

  const UpdateTaskUseCase(this._todayRepository);

  Future<void> call(TaskEntity task) {
    return _todayRepository.updateTask(task);
  }
}
