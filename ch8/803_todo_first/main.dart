import 'package:flutter/material.dart';
import 'package:todo_list/secondDetail.dart';
import 'package:todo_list/subDetail.dart';
import 'package:todo_list/thirdPage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second' : (context) => SecondDetail(),
        '/third' : (context) => ThirdPage(),
      },
    );
  }
}
