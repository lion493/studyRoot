import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Container(
        child:  Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.value.text);
                },
                child: Text('저장하기'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/third');
                },
                child: Text('세번째 페이지로 가기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}