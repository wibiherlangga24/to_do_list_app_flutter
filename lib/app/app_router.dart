import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo_list_app_flutter/yesterday_page.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  int _selectedIndex = 0;

  List<Widget> allPage = [
    const YesterdayPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const YesterdayPage(),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: SafeArea(
          child: GNav(
            gap: 8,
            backgroundColor: Colors.black,
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
            onTabChange: (index) {},
          ),
        ),
      ),
    );
  }
}
