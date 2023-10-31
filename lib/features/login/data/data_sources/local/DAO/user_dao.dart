import 'package:floor/floor.dart';
import 'package:todo_list_app_flutter/features/login/data/models/user_model.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> registerUser(UserModel user);

  @Query('SELECT * FROM user WHERE email = :email')
  Future<List<UserModel>> findEmailUser(String email);

  @Query('SELECT * FROM user WHERE email = :email AND password = :password')
  Future<List<UserModel>> loginUser(String email, String password);
}
