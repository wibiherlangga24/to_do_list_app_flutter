import '../../../add_task/domain/entity/task_entity.dart';

abstract class TodayState {
  final List<TaskEntity>? planTasks;
  final List<TaskEntity>? doneTasks;
  const TodayState({this.planTasks, this.doneTasks});
}

class TodayLoading extends TodayState {
  const TodayLoading();
}

class TodayDone extends TodayState {
  const TodayDone(
    List<TaskEntity> planTasks,
    List<TaskEntity> doneTasks,
  ) : super(planTasks: planTasks, doneTasks: doneTasks);
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
