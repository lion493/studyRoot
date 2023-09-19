import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third page'),
      ),
      body: Container(
        child:  Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('첫번째 페이지로 돌아가기'),
          ),
        ),
      ),
    );
  }
}