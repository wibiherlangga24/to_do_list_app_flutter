import 'package:bloc/bloc.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_event.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_state.dart';

import '../../domain/use_cases/save_task_use_case.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final SaveTaskUseCase _saveTaskUseCase;

  AddTaskBloc(
    this._saveTaskUseCase,
  ) : super(SnackBarStateNone()) {
    on<AddTask>(_onAddNewTask);
  }

  Future<void> _onAddNewTask(AddTask event, Emitter<AddTaskState> emit) async {
    final TaskEntity task = TaskEntity(
      title: event.titleTask,
      dateTime: event.dateTask,
      description: event.descriptionTask,
      status: 1,
    );

    await _saveTaskUseCase.call(task);

    emit(
      const SnackBarStateSuccess(
        'Success submit new task',
      ),
    );
  }
}
