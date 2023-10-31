import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_flutter/features/login/domain/entity/user_entity.dart';
import 'package:todo_list_app_flutter/features/login/presentation/bloc/user_event.dart';
import 'package:todo_list_app_flutter/features/login/presentation/bloc/user_state.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/validate_user_use_case.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUseCase _registerUseCase;
  final ValidateUserUseCase _validateUserUseCase;
  final LoginUseCase _loginUseCase;

  UserBloc(
    this._registerUseCase,
    this._validateUserUseCase,
    this._loginUseCase,
  ) : super(const SnackBarStateNone()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<UserState> emit) async {
    final isUserExist = await _validateUserUseCase.call(event.email);

    if (isUserExist.isNotEmpty) {
      final users = await _loginUseCase.call(event.email, event.password);
      await handleLoginUser(users, emit);
    } else {
      emit(const SnackBarStateError('account is not exist, please register'));
    }
  }

  Future<void> handleLoginUser(
      List<UserEntity> user, Emitter<UserState> emit) async {
    if (user.isEmpty) {
      emit(const SnackBarStateError('email or password is incorrect'));
    } else {
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString('email', user[0].email ?? '');
      sharedPref.setString('name', user[0].name ?? '');
      emit(const SnackBarStateSuccess('login successfully!'));
    }
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<UserState> emit) async {
    final isUserExist = await _validateUserUseCase.call(event.email);

    if (isUserExist.isEmpty) {
      final newUser = UserEntity(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      await _registerUseCase.call(newUser);

      emit(const SnackBarStateSuccess('Register a new user successfully!'));
    } else {
      emit(const SnackBarStateError(
          'Email has registered, please using another email'));
    }
  }
}
