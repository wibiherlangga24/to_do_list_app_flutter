import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';
import 'package:todo_list_app_flutter/features/login/domain/repository/user_repository.dart';

class ValidateUserUseCase {
  final UserRepository _userRepository;

  const ValidateUserUseCase(
    this._userRepository,
  );

  Future<List<UserEntity>> call(String email) {
    return _userRepository.checkEmail(email);
  }
}
