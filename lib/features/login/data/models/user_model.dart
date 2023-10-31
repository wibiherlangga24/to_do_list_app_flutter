import 'package:floor/floor.dart';
import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';

@Entity(tableName: 'user', primaryKeys: ['email'])
class UserModel extends UserEntity {
  const UserModel({
    String? name,
    String? email,
    String? password,
  }) : super(
          name: name,
          email: email,
          password: password,
        );

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }
}
