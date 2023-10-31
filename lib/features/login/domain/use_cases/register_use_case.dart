import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';
import 'package:todo_list_app_flutter/features/login/domain/repository/user_repository.dart';

class RegisterUseCase {
  final UserRepository _userRepository;

  const RegisterUseCase(this._userRepository);

  Future<void> call(UserEntity user) {
    return _userRepository.register(user);
  }
}
