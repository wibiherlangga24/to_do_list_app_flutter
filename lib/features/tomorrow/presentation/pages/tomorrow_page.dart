import 'package:flutter/material.dart';

class TomorrowPage extends StatefulWidget {
  const TomorrowPage({Key? key}) : super(key: key);

  @override
  State<TomorrowPage> createState() => _TomorrowPageState();
}

class _TomorrowPageState extends State<TomorrowPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tomorrow'),
    );
  }
}
