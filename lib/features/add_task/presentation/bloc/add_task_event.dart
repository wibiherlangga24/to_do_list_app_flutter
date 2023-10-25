abstract class AddTaskEvent {
  const AddTaskEvent();
}

class AddTask extends AddTaskEvent {
  final String titleTask;
  final String dateTask;
  final String descriptionTask;

  const AddTask(this.titleTask, this.dateTask, this.descriptionTask);
}

class ValidateTask extends AddTaskEvent {
  const ValidateTask();
}
