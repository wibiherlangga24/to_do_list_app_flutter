import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/tomorrow/presentation/bloc/tomorrow_event.dart';
import 'package:todo_list_app_flutter/features/tomorrow/presentation/bloc/tomorrow_state.dart';
import '../../domain/use_cases/tomorrow_delete_task_use_case.dart';
import '../../domain/use_cases/tomorrow_get_task_use_case.dart';
import '../../domain/use_cases/tomorrow_update_task_use_case.dart';

class TomorrowBloc extends Bloc<TomorrowEvent, TomorrowState> {
  final TomorrowGetTaskUseCase _getTaskUseCase;
  final TomorrowDeleteTaskUseCase _deleteTaskUseCase;
  final TomorrowUpdateTaskUseCase _updateTaskUseCase;

  TomorrowBloc(
    this._getTaskUseCase,
    this._deleteTaskUseCase,
    this._updateTaskUseCase,
  ) : super(TomorrowLoading()) {
    on<GetSavedTasks>(_onGetSavedTasks);
    on<DeleteTask>(_onRemoveTask);
    on<UpdateDateTask>(_onUpdateDateTask);
  }

  Future<void> _showTasks(Emitter<TomorrowState> emit) async {
    final tasks = await _getTaskUseCase.call(_getDateTomorrow());

    print('tasks tomorrow: ${tasks}');

    emit(
      TomorrowDone(tasks),
    );
  }

  Future<void> _onGetSavedTasks(
      GetSavedTasks event, Emitter<TomorrowState> emit) async {
    await _showTasks(emit);
  }

  Future<void> _onRemoveTask(
      DeleteTask event, Emitter<TomorrowState> emit) async {
    await _deleteTaskUseCase.call(event.task!);
    await _showTasks(emit);
  }

  Future<void> _onUpdateDateTask(
      UpdateDateTask event, Emitter<TomorrowState> emit) async {
    final TaskEntity task = event.task!.copyWith(
      id: event.task?.id,
      title: event.task?.title,
      dateTime: _getDateNow(),
      description: event.task?.description,
      status: 0,
    );

    await _updateTaskUseCase.call(task);
    await _showTasks(emit);
  }

  String _getDateNow() {
    final getDateNow = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(getDateNow);
  }

  String _getDateTomorrow() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return DateFormat('dd-MM-yyyy').format(tomorrow);
  }
}
