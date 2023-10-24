import 'package:flutter/material.dart';
import 'package:todo_list_app_flutter/config/theme/theme_text_style.dart';
import 'package:todo_list_app_flutter/features/add_task/presentation/pages/create_today_page.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToCreateTodoListPage(context);
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget planSection(BuildContext context) {
    final bool isPlanSectionExist = true;

    if (!isPlanSectionExist) {
      return SizedBox.shrink();
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
            itemCount: 1,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return toDoListCard(context, index, Colors.lightBlue[50]!);
            },
          ),
        ],
      ),
    );
  }

  Widget doneSection(BuildContext context) {
    final bool isDoneSectionExist = true;

    if (!isDoneSectionExist) {
      return SizedBox.shrink();
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
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return toDoListCard(context, index, Colors.lightGreen[50]!);
            },
          ),
        ],
      ),
    );
  }

  Widget toDoListCard(BuildContext context, int index, Color color) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: toDoListItem(context, index, color),
    );
  }

  Widget toDoListItem(BuildContext context, int index, Color color) {
    final loremIpsum =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

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
                  'Meeting with client',
                  style: ThemeTextStyle.MuseoSans700w400.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Icon(
                Icons.settings,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            loremIpsum,
            style: ThemeTextStyle.MuseoSans500w400.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _goToCreateTodoListPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CreateTodayPage(),
    ));
  }
}
