abstract class AddTaskState {
  const AddTaskState();
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
