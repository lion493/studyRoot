import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LaregeFileMain();
}

//https://images.pexels.com/photos/3222685/pexels-photo-3222685.jpeg
class _LaregeFileMain extends State<LargeFileMain> {
  final imgUrl =
      'https://images.pexels.com/photos/18193597/pexels-photo-18193597.jpeg';
  bool downloading = false;
  var progressString = "";
  String file = "";
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController(
        text:
            'https://raw.githubusercontent.com/lion493/studyRoot/main/ch7/quil01.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example 2 - 직접주소를 입력해서 다운 '),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _editingController,
              style: TextStyle(color: Colors.blue),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'url 입력하세요'),
            ),
            ElevatedButton(
              child: Text('getUrl_Image'),
              onPressed: () {
                print('button onPressed !! ');
                downloadFile();
              },
            ),
            Center(
                child: downloading
                    ? Container(
                        height: 120.0,
                        width: 200.0,
                        child: Card(
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Downloading File : $progressString',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    : FutureBuilder(
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              print('none');
                              return Text('데이터없음');
                            case ConnectionState.waiting:
                              print('waiting');
                              return CircularProgressIndicator();
                            case ConnectionState.active:
                              print('active');
                              return CircularProgressIndicator();
                            case ConnectionState.done:
                              print('done');
                              if (snapshot.hasData) {
                                return snapshot.data as Widget;
                              }
                          }
                          print('end process');
                          return Text('데이터없음');
                        },
                        future: downloadWidget(file),
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if (exist) {
      return Center(
        child: Column(
          children: <Widget>[Image.file(File(filePath), fit: BoxFit.contain, )],
        ),
      );
    } else {
      return Text('No Data');
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      String downImageUrl = '';
      //downImageUrl = imgUrl;
      downImageUrl = _editingController!.value.text;
      print(downImageUrl);
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(downImageUrl, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        print('Rec: $rec , Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download completed.');
  }
}
