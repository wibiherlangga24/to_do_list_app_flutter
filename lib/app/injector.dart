import 'package:get_it/get_it.dart';
import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/repository/task_repository_impl.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/repository/task_repository.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/use_cases/save_task_use_case.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:todo_list_app_flutter/features/today/domain/repository/today_repository.dart';
import 'package:todo_list_app_flutter/features/today/domain/use_cases/delete_task_use_case.dart';
import 'package:todo_list_app_flutter/features/today/domain/use_cases/get_task_use_case.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_bloc.dart';

import '../features/today/data/repository/today_repository_impl.dart';
import '../features/today/domain/use_cases/update_task_use_case.dart';
import '../features/tomorrow/data/repository/tomorrow_repository_impl.dart';
import '../features/tomorrow/domain/repository/tomorrow_repository.dart';
import '../features/tomorrow/domain/use_cases/tomorrow_delete_task_use_case.dart';
import '../features/tomorrow/domain/use_cases/tomorrow_get_task_use_case.dart';
import '../features/tomorrow/domain/use_cases/tomorrow_update_task_use_case.dart';
import '../features/tomorrow/presentation/bloc/tomorrow_bloc.dart';
import '../features/yesterday/data/repository/yesterday_repository_impl.dart';
import '../features/yesterday/domain/repository/yesterday_repository.dart';
import '../features/yesterday/domain/use_cases/yesterday_get_task_use_case.dart';
import '../features/yesterday/domain/use_cases/yesterday_update_task_use_case.dart';
import '../features/yesterday/presentation/bloc/yesterday_bloc.dart';

final sl = GetIt.instance;

Future<void> initDepedencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Repositories
  sl.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(sl()),
  );
  sl.registerSingleton<TodayRepository>(
    TodayRepositoryImpl(sl()),
  );
  sl.registerSingleton<YesterdayRepository>(
    YesterdayRepositoryImpl(sl()),
  );
  sl.registerSingleton<TomorrowRepository>(
    TomorrowRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(sl()));
  sl.registerSingleton<GetTaskUseCase>(GetTaskUseCase(sl()));
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(sl()));
  sl.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase(sl()));
  sl.registerSingleton<YesterdayGetTaskUseCase>(YesterdayGetTaskUseCase(sl()));
  sl.registerSingleton<YesterdayUpdateTaskUseCase>(
      YesterdayUpdateTaskUseCase(sl()));

  sl.registerSingleton<TomorrowGetTaskUseCase>(TomorrowGetTaskUseCase(sl()));
  sl.registerSingleton<TomorrowUpdateTaskUseCase>(
      TomorrowUpdateTaskUseCase(sl()));
  sl.registerSingleton<TomorrowDeleteTaskUseCase>(
      TomorrowDeleteTaskUseCase(sl()));

  // Blocs
  sl.registerFactory<AddTaskBloc>(() => AddTaskBloc(sl()));
  sl.registerFactory<TodayBloc>(() => TodayBloc(sl(), sl(), sl()));
  sl.registerFactory<YesterdayBloc>(() => YesterdayBloc(sl(), sl()));
  sl.registerFactory<TomorrowBloc>(() => TomorrowBloc(sl(), sl(), sl()));
}
