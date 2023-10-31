import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';
import 'package:todo_list_app_flutter/features/login/domain/repository/user_repository.dart';

class LoginUseCase {
  final UserRepository _userRepository;

  const LoginUseCase(this._userRepository);

  Future<List<UserEntity>> call(String email, String password) {
    return _userRepository.login(email, password);
  }
}
