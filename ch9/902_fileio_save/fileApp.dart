import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    recordCountFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File 연습 Example'),),
      body: Container(
        child: Center(
          child: Text('$_count'
              ,style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
          writeCountfile(_count);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void recordCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '\ncount.txt').readAsString();
      print(dir.path);
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString() );
    }
  }

  void writeCountfile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '\ncount.txt').writeAsString(count.toString());
  }

}