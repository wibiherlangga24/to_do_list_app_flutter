import '../../../add_task/domain/entity/task_entity.dart';

abstract class TomorrowState {
  final List<TaskEntity>? tasks;
  const TomorrowState({this.tasks});
}

class TomorrowLoading extends TomorrowState {
  const TomorrowLoading();
}

class TomorrowDone extends TomorrowState {
  const TomorrowDone(
    List<TaskEntity> tasks,
  ) : super(tasks: tasks);
}

class SnackBarStateNone extends TomorrowState {
  const SnackBarStateNone();
}

class SnackBarStateError extends TomorrowState {
  final String message;
  const SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends TomorrowState {
  final String message;
  const SnackBarStateSuccess(
    this.message,
  );
}
