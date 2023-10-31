import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
import 'package:todo_list_app_flutter/features/login/presentation/pages/login_page.dart';
import 'package:todo_list_app_flutter/features/today/presentation/pages/today_page.dart';
import 'package:todo_list_app_flutter/features/tomorrow/presentation/pages/tomorrow_page.dart';
import 'package:todo_list_app_flutter/features/yesterday/presentation/pages/yesterday_page.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  int _selectedIndex = 0;

  List<Widget> allPage = [
    const YesterdayPage(),
    const TodayPage(),
    const TomorrowPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My To do List',
          style: ThemeTextStyle.MuseoSans700w400.copyWith(
            fontSize: 25,
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () async {
              await _logout(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: allPage[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.orange,
              activeColor: Colors.orange,
              tabBackgroundColor: Colors.grey.shade700,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.calendar_view_day_outlined,
                  text: 'Yesterday',
                ),
                GButton(
                  icon: Icons.calendar_today,
                  text: 'Today',
                ),
                GButton(
                  icon: Icons.calendar_month_rounded,
                  text: 'Tomorrow',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('email');
    sharedPref.remove('name');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }
}
