abstract class UserState {
  const UserState();
}

class SnackBarStateNone extends UserState {
  const SnackBarStateNone();
}

class SnackBarStateError extends UserState {
  final String message;
  const SnackBarStateError(
    this.message,
  );
}

class SnackBarStateSuccess extends UserState {
  final String message;
  const SnackBarStateSuccess(
    this.message,
  );
}
