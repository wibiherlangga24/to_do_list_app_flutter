import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
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
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: allPage[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: SafeArea(
          child: GNav(
            gap: 8,
            backgroundColor: Colors.orange,
            color: Colors.white,
            activeColor: Colors.white,
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
    );
  }
}
