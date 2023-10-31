import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_event.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_state.dart';
import '../../domain/use_cases/delete_task_use_case.dart';
import '../../domain/use_cases/get_task_use_case.dart';
import '../../domain/use_cases/update_task_use_case.dart';

class TodayBloc extends Bloc<TodayEvent, TodayState> {
  final GetTaskUseCase _getTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  TodayBloc(
    this._getTaskUseCase,
    this._deleteTaskUseCase,
    this._updateTaskUseCase,
  ) : super(const TodayLoading()) {
    on<GetSavedTasks>(_onGetSavedTasks);
    on<DeleteTask>(_onRemoveTask);
    on<UpdateStatusTask>(_onUpdateStatusTask);
    on<UpdateDateTask>(_onUpdateDateTask);
  }

  Future<void> _showTasks(Emitter<TodayState> emit) async {
    final tasks = await _getTaskUseCase.call(_getDateNow());
    final getPlanTasks = await _getPlanTasks(tasks);
    final getDoneTasks = await _getDoneTasks(tasks);

    emit(
      TodayDone(getPlanTasks, getDoneTasks),
    );
  }

  Future<void> _onGetSavedTasks(
      GetSavedTasks event, Emitter<TodayState> emit) async {
    await _showTasks(emit);
  }

  Future<void> _onRemoveTask(DeleteTask event, Emitter<TodayState> emit) async {
    await _deleteTaskUseCase.call(event.task!);
    await _showTasks(emit);
  }

  Future<void> _onUpdateStatusTask(
      UpdateStatusTask event, Emitter<TodayState> emit) async {
    final TaskEntity task = event.task!.copyWith(
      id: event.task?.id,
      title: event.task?.title,
      dateTime: event.task?.dateTime,
      description: event.task?.description,
      status: 1,
      userId: event.task?.userId,
    );

    await _updateTaskUseCase.call(task);

    await _showTasks(emit);
  }

  Future<void> _onUpdateDateTask(
      UpdateDateTask event, Emitter<TodayState> emit) async {
    final TaskEntity task = event.task!.copyWith(
      id: event.task?.id,
      title: event.task?.title,
      dateTime: _getDateTomorrow(),
      description: event.task?.description,
      status: 0,
      userId: event.task?.userId,
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

  Future<List<TaskEntity>> _getPlanTasks(List<TaskEntity> tasks) async {
    final result = tasks.where((element) => element.status == 0).toList();
    return result;
  }

  Future<List<TaskEntity>> _getDoneTasks(List<TaskEntity> tasks) async {
    final result = tasks.where((element) => element.status == 1).toList();
    return result;
  }
}
