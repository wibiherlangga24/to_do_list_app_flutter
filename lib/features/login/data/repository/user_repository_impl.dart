import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';
import 'package:todo_list_app_flutter/features/login/domain/repository/user_repository.dart';

import '../../../add_task/data/data_sources/local/app_database.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final AppDatabase _appDatabase;

  UserRepositoryImpl(this._appDatabase);

  @override
  Future<List<UserEntity>> login(String email, String password) async {
    return _appDatabase.userDAO.loginUser(email, password);
  }

  @override
  Future<void> register(UserEntity user) async {
    return _appDatabase.userDAO.registerUser(UserModel.fromEntity(user));
  }

  @override
  Future<List<UserEntity>> checkEmail(String email) {
    return _appDatabase.userDAO.findEmailUser(email);
  }
}
