import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';

abstract class AddTaskEvent {
  const AddTaskEvent();
}

class AddTask extends AddTaskEvent {
  final String titleTask;
  final String dateTask;
  final String descriptionTask;

  const AddTask(this.titleTask, this.dateTask, this.descriptionTask);
}

class UpdateTask extends AddTaskEvent {
  final String titleTask;
  final String dateTask;
  final String descriptionTask;
  final TaskEntity task;

  const UpdateTask(
      this.titleTask, this.dateTask, this.descriptionTask, this.task);
}
