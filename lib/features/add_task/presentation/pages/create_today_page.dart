import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
import 'package:todo_list_app_flutter/core/mixin/snack_bar_mixin.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_event.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/bloc/add_task_state.dart';

class CreateTodayPage extends StatefulWidget {
  const CreateTodayPage({Key? key}) : super(key: key);

  @override
  State<CreateTodayPage> createState() => _CreateTodayPageState();
}

class _CreateTodayPageState extends State<CreateTodayPage> with SnackBarMixin {
  TextEditingController dateCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _bloc = GetIt.I.get<AddTaskBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider<AddTaskBloc>.value(
      value: _bloc,
      child: BlocListener<AddTaskBloc, AddTaskState>(
        bloc: _bloc,
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is SnackBarStateError) {
            showErrorSnackBar(context, message: state.message);
          } else if (state is SnackBarStateSuccess) {
            showSuccessSnackBar(context, message: state.message);
          } else {
            removeSnackBar(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Task',
                style: ThemeTextStyle.MuseoSans700w400.copyWith(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter Task Name',
                        ),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Task Name must fill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: dateCtl,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Enter Date',
                        ),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Date must fill";
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          _selectDate(context);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter Description',
                        ),
                        minLines: 1,
                        maxLines: 10,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(),
                          NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              _createNewTask(context);
                            },
                            style: NeumorphicStyle(
                              color: Colors.green,
                              shadowDarkColor: Colors.grey,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? date = DateTime(1900);

    date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 7),
      ),
    );

    if (date != null) {
      dateCtl.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void _createNewTask(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _bloc.add(AddTask('Test', DateTime.now(), 'Test Desc'));
    }
  }
}
