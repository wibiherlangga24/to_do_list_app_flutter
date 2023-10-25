import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
import 'package:todo_list_app_flutter/core/mixin/snack_bar_mixin.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/pages/create_today_page.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_bloc.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_event.dart';
import 'package:todo_list_app_flutter/features/today/presentation/bloc/today_state.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with SnackBarMixin {
  final _bloc = GetIt.I.get<TodayBloc>();

  final List<String> optionsMenu = ['Remove', 'Done', 'Move for tomorrow'];

  @override
  void initState() {
    super.initState();

    _bloc.add(GetSavedTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayBloc>.value(
      value: _bloc,
      child: BlocListener<TodayBloc, TodayState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is SnackBarStateError) {
            showErrorSnackBar(context, message: state.message);
          } else if (state is SnackBarStateSuccess) {
            showSuccessSnackBar(context, message: state.message);
          } else {
            removeSnackBar(context);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                planSection(context),
                doneSection(context),
              ],
            ),
          ),
          floatingActionButton: _floatingActionButtonWidget(context),
        ),
      ),
    );
  }

  Widget? _floatingActionButtonWidget(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.planTasks == null && state.doneTasks == null) {
          return SizedBox.shrink();
        } else if (state.planTasks!.isEmpty && state.doneTasks!.isEmpty) {
          return SizedBox.shrink();
        } else {
          return FloatingActionButton(
            onPressed: () {
              _goToCreateTodoListPage(context);
            },
            backgroundColor: Colors.orange,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget planSection(BuildContext context) {
    return BlocSelector<TodayBloc, TodayState, List<TaskEntity>?>(
      bloc: _bloc,
      selector: (state) => state.planTasks,
      builder: (context, state) {
        if (state == null || state.isEmpty) {
          return _emptyPage(context);
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PLAN:",
                style: ThemeTextStyle.MuseoSans700w400.copyWith(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return toDoListCard(context, index, Colors.lightBlue[50]!,
                      state[index], true);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget doneSection(BuildContext context) {
    return BlocSelector<TodayBloc, TodayState, List<TaskEntity>?>(
      bloc: _bloc,
      selector: (state) => state.doneTasks,
      builder: (context, state) {
        if (state == null || state.isEmpty) {
          return _emptyPage(context);
        }
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DONE:",
                style: ThemeTextStyle.MuseoSans700w400.copyWith(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return toDoListCard(context, index, Colors.lightGreen[50]!,
                      state[index], false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyPage(BuildContext context) {
    return BlocBuilder<TodayBloc, TodayState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.planTasks == null && state.doneTasks == null) {
          return Center(
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (c, s) => s.connectionState == ConnectionState.done
                  ? Text(
                      'Add to do list first',
                      style: ThemeTextStyle.MuseoSans500w400.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          );
        } else if (state.planTasks!.isEmpty && state.doneTasks!.isEmpty) {
          return Center(
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (c, s) => s.connectionState == ConnectionState.done
                  ? Text(
                      'Add to do list first',
                      style: ThemeTextStyle.MuseoSans500w400.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget toDoListCard(BuildContext context, int index, Color color,
      TaskEntity task, bool showOptions) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: toDoListItem(context, index, color, task, showOptions),
    );
  }

  Widget toDoListItem(BuildContext context, int index, Color color,
      TaskEntity task, bool showOptions) {
    return Container(
      color: color,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title ?? '',
                  style: ThemeTextStyle.MuseoSans700w400.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              _optionWidget(context, task, showOptions),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            task.description ?? '',
            style: ThemeTextStyle.MuseoSans500w400.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionWidget(BuildContext context, TaskEntity task, bool show) {
    if (!show) {
      return const SizedBox.shrink();
    }

    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_horiz),
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        optionsMenu.length,
        (int index) => MenuItemButton(
          onPressed: () {
            _showOptionPressed(context, index, task);
          },
          child: Text(optionsMenu[index]),
        ),
      ),
    );
  }

  void _showOptionPressed(BuildContext context, int index, TaskEntity task) {
    switch (index) {
      case 0:
        // Delete task
        _bloc.add(DeleteTask(task));
      case 1:
        // Update Task Status into Done
        _bloc.add(UpdateStatusTask(task));
      case 2:
        // Update Task Date into tomorrow
        _bloc.add(UpdateDateTask(task));
    }
  }

  void _goToCreateTodoListPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => CreateTodayPage(),
    ))
        .then((_) {
      _bloc.add(GetSavedTasks());
    });
  }
}
