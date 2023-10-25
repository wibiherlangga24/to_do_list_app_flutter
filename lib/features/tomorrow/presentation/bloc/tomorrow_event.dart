import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class TomorrowEvent {
  final TaskEntity? task;
  const TomorrowEvent({this.task});
}

class GetSavedTasks extends TomorrowEvent {
  const GetSavedTasks();
}

class DeleteTask extends TomorrowEvent {
  const DeleteTask(TaskEntity task) : super(task: task);
}

class UpdateDateTask extends TomorrowEvent {
  const UpdateDateTask(TaskEntity task) : super(task: task);
}
