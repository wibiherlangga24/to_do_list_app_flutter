import '../../../add_task/domain/entity/task_entity.dart';

abstract class YesterdayState {
  final List<TaskEntity>? planTasks;
  final List<TaskEntity>? doneTasks;
  const YesterdayState({this.planTasks, this.doneTasks});
}

class YesterdayLoading extends YesterdayState {
  const YesterdayLoading();
}

class YesterdayDone extends YesterdayState {
  const YesterdayDone(
      List<TaskEntity> planTasks,
      List<TaskEntity> doneTasks,
  ) : super(planTasks: planTasks, doneTasks: doneTasks);
}

class SnackBarStateNone extends YesterdayState {
  const SnackBarStateNone();
}

class SnackBarStateError extends YesterdayState {
  final String message;
  const SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends YesterdayState {
  final String message;
  const SnackBarStateSuccess(
    this.message,
  );
}
