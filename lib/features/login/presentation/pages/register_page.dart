import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app_flutter/core/mixin/snack_bar_mixin.dart';
import 'package:todo_list_app_flutter/features/login/presentation/bloc/user_bloc.dart';
import 'package:todo_list_app_flutter/features/login/presentation/bloc/user_event.dart';
import 'package:todo_list_app_flutter/features/login/presentation/bloc/user_state.dart';
import 'package:todo_list_app_flutter/features/login/presentation/pages/login_page.dart';

import '../../../../config/theme/theme_text_style.dart';
import '../widgets/clipper.dart';
import '../widgets/clipper2.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SnackBarMixin {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _bloc = GetIt.I.get<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>.value(
      value: _bloc,
      child: BlocListener<UserBloc, UserState>(
        bloc: _bloc,
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is SnackBarStateError) {
            showErrorSnackBar(context, message: state.message);
          } else if (state is SnackBarStateSuccess) {
            showSuccessSnackBarAndBackAction(context, message: state.message);
          } else {
            removeSnackBar(context);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 300),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      top: 16,
                      right: -5,
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 300),
                        painter: RPCustomPainter(),
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: ThemeTextStyle.MuseoSans700w400.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please Fill this form.',
                            style: ThemeTextStyle.MuseoSans500w400.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        _getNameWidget(context),
                        const SizedBox(
                          height: 25,
                        ),
                        _getEmailWidget(context),
                        const SizedBox(
                          height: 25,
                        ),
                        _getPasswordWidget(context),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () => _registerBtnTapped(context),
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xfff7b858),
                                Color(0xfffca148),
                              ]),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'REGISTER',
                                  style:
                                      ThemeTextStyle.MuseoSans500w400.copyWith(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?",
                              style: ThemeTextStyle.MuseoSans700w400.copyWith(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () => _goToSignIn(context),
                              child: Text(
                                "Sign in",
                                style: ThemeTextStyle.MuseoSans700w400.copyWith(
                                  fontSize: 16,
                                  color: Color(0xfffca148),
                                ),
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
      ),
    );
  }

  Widget _getNameWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 6,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: TextFormField(
        controller: nameCtl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.person),
          hintText: 'Enter your name',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your name";
          }
        },
      ),
    );
  }

  Widget _getEmailWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 6,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: TextFormField(
        controller: emailCtl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.email_outlined),
          hintText: 'Enter your email',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your email";
          }

          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return "Enter correct email";
          }

          return null;
        },
      ),
    );
  }

  Widget _getPasswordWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 6,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: TextFormField(
        obscureText: true,
        controller: passwordCtl,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14,
          ),
          prefixIcon: Icon(Icons.lock_outline_rounded),
          hintText: 'Enter your password',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your password";
          }

          if (value.length < 6) {
            return "Password should have 6 Character";
          }

          return null;
        },
      ),
    );
  }

  void _registerBtnTapped(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        RegisterUser(nameCtl.text, emailCtl.text, passwordCtl.text),
      );
    }
  }

  void _goToSignIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  }
}
