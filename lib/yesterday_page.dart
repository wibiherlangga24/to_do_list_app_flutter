import 'package:flutter/material.dart';

class YesterdayPage extends StatefulWidget {
  const YesterdayPage({Key? key}) : super(key: key);

  @override
  State<YesterdayPage> createState() => _YesterdayPageState();
}

class _YesterdayPageState extends State<YesterdayPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Yesterday'),
    );
  }
}
