import '../../domain/entity/task_entity.dart';

abstract class AddTaskState {
  final List<TaskEntity>? tasks;
  const AddTaskState({this.tasks});
}

class TaskLoading extends AddTaskState {
  const TaskLoading();
}

class TaskDone extends AddTaskState {
  const TaskDone(
    List<TaskEntity> tasks,
  ) : super(tasks: tasks);
}

class SnackBarStateNone extends AddTaskState {
  const SnackBarStateNone();
}

class SnackBarStateError extends AddTaskState {
  final String message;
  const SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends AddTaskState {
  final String message;
  const SnackBarStateSuccess(
    this.message,
  );
}
