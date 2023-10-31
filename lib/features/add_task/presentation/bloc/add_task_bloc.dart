import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_event.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_state.dart';
import '../../../add_task/domain/use_cases/update_task_selected_use_case.dart';
import '../../domain/use_cases/save_task_use_case.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final SaveTaskUseCase _saveTaskUseCase;
  final UpdateTaskSelectedUseCase _updateTaskUseCase;

  AddTaskBloc(
    this._saveTaskUseCase,
    this._updateTaskUseCase,
  ) : super(SnackBarStateNone()) {
    on<AddTask>(_onAddNewTask);
    on<UpdateTask>(_onUpdateTask);
  }

  Future<void> _onAddNewTask(AddTask event, Emitter<AddTaskState> emit) async {
    final sharedPref = await SharedPreferences.getInstance();
    final obtainEmail = sharedPref.getString('email');

    final TaskEntity task = TaskEntity(
      title: event.titleTask,
      dateTime: event.dateTask,
      description: event.descriptionTask,
      status: 0,
      userId: obtainEmail,
    );

    await _saveTaskUseCase.call(task);

    emit(
      const SnackBarStateSuccess(
        'Success submit new task',
      ),
    );
  }

  Future<void> _onUpdateTask(
      UpdateTask event, Emitter<AddTaskState> emit) async {
    final TaskEntity task = event.task.copyWith(
      id: event.task.id,
      title: event.titleTask,
      dateTime: event.dateTask,
      description: event.descriptionTask,
      status: event.task.status,
      userId: event.task.userId,
    );

    await _updateTaskUseCase.call(task);

    emit(
      const SnackBarStateSuccess(
        'Success submit update task',
      ),
    );
  }
}
