import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    recordCountFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File 연습 Listview Example'),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(
                          itemList[index],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                  itemCount: itemList.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeFruit(controller.value.text);
          setState(() {
            itemList.add(controller.value.text);
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

  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '\nfruit.txt').exists();

    if(firstCheck == null || firstCheck == false || fileExist == false ) {
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '\nfruit.txt').writeAsStringSync(file);  //최초에는 repo에서 읽어서 디폴트경로에 쓴다.
      var array = file.split('\n');
      for(var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    } else { //이미 값이 있는경우
      var file = await File(dir.path + '\nfruit.txt').readAsString();
      var array = file.split('\n');
      for(var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    }
  }
  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '\nfruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '\nfruit.txt').writeAsStringSync(file);
  }

}