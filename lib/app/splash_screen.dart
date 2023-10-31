import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_flutter/app/app_router.dart';
import 'package:todo_list_app_flutter/features/login/presentation/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;

  @override
  void initState() {
    _getUserCredential().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        finalEmail != null ? goToMainPage() : goToLoginPage();
      });
    });

    super.initState();
  }

  Future _getUserCredential() async {
    final sharedPref = await SharedPreferences.getInstance();
    final obtainedEmail = sharedPref.getString('email');

    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  void goToLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }

  void goToMainPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const AppRouter(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "logo",
          child: Image.asset('assets/to_do_list_img.png'),
        ),
      ),
    );
  }
}
