import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class YesterdayEvent {
  final TaskEntity? task;
  const YesterdayEvent({this.task});
}

class GetSavedTasks extends YesterdayEvent {
  const GetSavedTasks();
}

class UpdateDateTask extends YesterdayEvent {
  const UpdateDateTask(TaskEntity task) : super(task: task);
}
