abstract class UserEvent {
  const UserEvent();
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  const LoginUser(this.email, this.password);
}

class RegisterUser extends UserEvent {
  final String name;
  final String email;
  final String password;

  const RegisterUser(this.name, this.email, this.password);
}
