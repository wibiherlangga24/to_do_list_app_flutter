import '../../../add_task/domain/entity/task_entity.dart';

abstract class TodayState {
  final List<TaskEntity>? tasks;

  const TodayState({this.tasks});
}

class TodayLoading extends TodayState {
  const TodayLoading();
}

class TodayDone extends TodayState {
  const TodayDone(List<TaskEntity> tasks) : super(tasks: tasks);
}

class SnackBarStateNone extends TodayState {
  const SnackBarStateNone();
}

class SnackBarStateError extends TodayState {
  final String message;
  const SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends TodayState {
  final String message;
  const SnackBarStateSuccess(
    this.message,
  );
}
