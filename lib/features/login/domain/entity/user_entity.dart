import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? password;

  const UserEntity({this.name, this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        password,
      ];

  UserEntity copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserEntity(
      name: name,
      email: email,
      password: password,
    );
  }
}
