import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
import 'package:todo_list_app_flutter/core/mixin/snack_bar_mixin.dart';
import 'package:todo_list_app_flutter/features/add_task/domain/entity/task_entity.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/pages/create_today_page.dart';
import '../../../add_task/presentation/pages/update_today_page.dart';
import '../bloc/tomorrow_bloc.dart';
import '../bloc/tomorrow_event.dart';
import '../bloc/tomorrow_state.dart';

class TomorrowPage extends StatefulWidget {
  const TomorrowPage({Key? key}) : super(key: key);

  @override
  State<TomorrowPage> createState() => _TomorrowPageState();
}

class _TomorrowPageState extends State<TomorrowPage> with SnackBarMixin {
  final _bloc = GetIt.I.get<TomorrowBloc>();

  final List<String> optionsMenu = ['Remove', 'Move for today'];

  @override
  void initState() {
    super.initState();

    _bloc.add(const GetSavedTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TomorrowBloc>.value(
      value: _bloc,
      child: BlocListener<TomorrowBloc, TomorrowState>(
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
          body: _buildBody(context),
          floatingActionButton: _floatingActionButtonWidget(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TomorrowBloc, TomorrowState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.tasks == null || state.tasks!.isEmpty) {
          return Center(
            child: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (c, s) => s.connectionState == ConnectionState.done
                  ? Center(
                      child: Text(
                        'Add to do list for tomorrow',
                        style: ThemeTextStyle.MuseoSans500w400.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                planSection(context),
              ],
            ),
          );
        }
      },
    );
  }

  Widget? _floatingActionButtonWidget(BuildContext context) {
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

  Widget planSection(BuildContext context) {
    return BlocSelector<TomorrowBloc, TomorrowState, List<TaskEntity>?>(
      bloc: _bloc,
      selector: (state) => state.tasks,
      builder: (context, state) {
        if (state == null || state.isEmpty) {
          return const SizedBox.shrink();
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
              const SizedBox(
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

  Widget toDoListCard(BuildContext context, int index, Color color,
      TaskEntity task, bool showOptions) {
    return InkWell(
      onTap: () {
        _goToUpdateTodoListPage(context, task);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: toDoListItem(context, index, color, task, showOptions),
      ),
    );
  }

  Widget toDoListItem(BuildContext context, int index, Color color,
      TaskEntity task, bool showOptions) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(10),
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
          const SizedBox(
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
        // Update Task Date into tomorrow
        _bloc.add(UpdateDateTask(task));
    }
  }

  void _goToCreateTodoListPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => const CreateTodayPage(),
    ))
        .then((_) {
      _bloc.add(const GetSavedTasks());
    });
  }

  void _goToUpdateTodoListPage(BuildContext context, TaskEntity task) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => UpdateTodayPage(
        task: task,
      ),
    ))
        .then((_) {
      _bloc.add(const GetSavedTasks());
    });
  }
}
