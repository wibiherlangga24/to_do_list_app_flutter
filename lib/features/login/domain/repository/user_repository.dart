import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> login(String email, String password);
  Future<List<UserEntity>> checkEmail(String email);
  Future<void> register(UserEntity user);
}
