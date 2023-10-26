import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/repository/task_repository.dart';

class UpdateTaskSelectedUseCase {
  final TaskRepository _taskRepository;

  const UpdateTaskSelectedUseCase(this._taskRepository);

  Future<void> call(TaskEntity task) {
    return _taskRepository.updateTask(task);
  }
}
