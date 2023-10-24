import 'package:get_it/get_it.dart';
import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/app_database.dart';
import 'package:todo_list_app_flutter/features/add_task/data/repository/task_repository_impl.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/repository/task_repository.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/use_cases/save_task_use_case.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_bloc.dart';

final sl = GetIt.instance;

Future<void> initDepedencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Repositories
  sl.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(sl()));

  // Blocs
  sl.registerFactory<AddTaskBloc>(() => AddTaskBloc(sl()));
}
