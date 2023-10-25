import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TodayEvent {
  final TaskEntity? task;
  const TodayEvent({this.task});
}

class GetSavedTasks extends TodayEvent {
  const GetSavedTasks();
}

class DeleteTask extends TodayEvent {
  const DeleteTask(TaskEntity task) : super(task: task);
}

class UpdateStatusTask extends TodayEvent {
  const UpdateStatusTask(TaskEntity task) : super(task: task);
}

class UpdateDateTask extends TodayEvent {
  const UpdateDateTask(TaskEntity task) : super(task: task);
}
