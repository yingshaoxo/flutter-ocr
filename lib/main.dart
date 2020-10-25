import 'dart:wasm';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'server.pb.dart';
import 'server.pbgrpc.dart';

final channel = ClientChannel(
  'localhost',
  port: 50051,
  options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
);
final stub = OCR_ServerClient(channel);

Future<void> main(List<String> args) async {
  try {
    final response = await stub.print(TextRequest()..text = "client started.");
    print(response.text);
  } on GrpcError {
    print("an grpc error");
  } catch (e) {
    print(e);
  }

  runApp(MyApp());

  //await channel.shutdown();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OCR',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Flutter OCR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final spinkit1 = Scaffold(
    appBar: null,
    backgroundColor: Colors.white,
    body: SpinKitFadingCube(
      size: 100,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    ));

final spinkit2 = Scaffold(
    appBar: null,
    backgroundColor: Colors.purple,
    body: SpinKitRing(
      size: 100,
      color: Colors.white,
    ));

class _MyHomePageState extends State<MyHomePage> {
  bool loading_finished = false;
  String file_path = "";
  String detected_text = "";

  bool wating = false;

  var input_controller;

  void initState() {
    super.initState();
    input_controller = TextEditingController();
  }

  void dispose() {
    input_controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (!loading_finished) {
      try {
        final response = await stub.load(TextRequest()..text = "");
        if (response.text == "ok") {
          setState(() {
            loading_finished = true;
          });
        }
      } catch (e) {
        print('Caught error: $e');
      }
    } else {}
    super.didChangeDependencies();
  }

  void do_the_scan() async {
    final response = await stub.scan(TextRequest()..text = file_path);
    print(response.text);
    //Map<String, dynamic> data = jsonDecode(response.text);
    Map data = jsonDecode(response.text);
    setState(() {
      detected_text = data["text"];
      wating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget left_part_widget;
    if (loading_finished) {
      left_part_widget = Text(
        'You can click the right bottom button to select an image to start your OCR journey.',
      );
    } else {
      left_part_widget = Text("Loading...");
      return spinkit1;
    }

    if (wating) {
      return spinkit2;
    }

    if (file_path != "") {
      left_part_widget = Image.file(new File(file_path));
    }

    input_controller.value = input_controller.value.copyWith(
      text: detected_text,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [left_part_widget],
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: input_controller,
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // show a dialog to open a file
          try {
            FilePickerCross myFile = await FilePickerCross.importFromStorage(
              type: FileTypeCross
                  .image, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
            );
            print(myFile.fileName);
            print(myFile.path);
            setState(() {
              file_path = myFile.path;
              wating = true;
            });
            do_the_scan();
          } catch (e) {
            print(e);
          }
        },
        tooltip: 'Add files',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
