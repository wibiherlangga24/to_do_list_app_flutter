import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/yesterday/presentation/bloc/yesterday_event.dart';
import 'package:todo_list_app_flutter/features/yesterday/presentation/bloc/yesterday_state.dart';
import '../../domain/use_cases/yesterday_get_task_use_case.dart';
import '../../domain/use_cases/yesterday_update_task_use_case.dart';

class YesterdayBloc extends Bloc<YesterdayEvent, YesterdayState> {
  final YesterdayGetTaskUseCase _getTaskUseCase;
  final YesterdayUpdateTaskUseCase _updateTaskUseCase;

  YesterdayBloc(
    this._getTaskUseCase,
    this._updateTaskUseCase,
  ) : super(YesterdayLoading()) {
    on<GetSavedTasks>(_onGetSavedTasks);
    on<UpdateDateTask>(_onUpdateDateTask);
  }

  Future<void> _showTasks(Emitter<YesterdayState> emit) async {
    final tasks = await _getTaskUseCase.call(_getDateYesterday());
    final getPlanTasks = await _getPlanTasks(tasks);
    final getDoneTasks = await _getDoneTasks(tasks);

    emit(
      YesterdayDone(getPlanTasks, getDoneTasks),
    );
  }

  Future<void> _onGetSavedTasks(
      GetSavedTasks event, Emitter<YesterdayState> emit) async {
    await _showTasks(emit);
  }

  Future<void> _onUpdateDateTask(
      UpdateDateTask event, Emitter<YesterdayState> emit) async {
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
    final now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  String _getDateYesterday() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return DateFormat('dd-MM-yyyy').format(yesterday);
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
