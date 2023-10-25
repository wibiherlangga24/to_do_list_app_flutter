import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import '../repository/tomorrow_repository.dart';

class TomorrowDeleteTaskUseCase {
  final TomorrowRepository _tomorrowRepository;

  const TomorrowDeleteTaskUseCase(this._tomorrowRepository);

  Future<void> call(TaskEntity task) {
    return _tomorrowRepository.removeTask(task);
  }
}
