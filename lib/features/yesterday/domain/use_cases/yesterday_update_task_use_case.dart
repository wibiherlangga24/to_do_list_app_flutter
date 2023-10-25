import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/yesterday/domain/repository/yesterday_repository.dart';

class YesterdayUpdateTaskUseCase {
  final YesterdayRepository _yesterdayRepository;

  const YesterdayUpdateTaskUseCase(this._yesterdayRepository);

  Future<void> call(TaskEntity task) {
    return _yesterdayRepository.updateTask(task);
  }
}
