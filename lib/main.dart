import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:desktop_window/desktop_window.dart';

import 'server.dart';

final service = Service();

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

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(Size(960, 640));

  service.say_hi();
  runApp(MaterialApp(
    title: 'Flutter OCR',
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading_finished = false;

  @override
  void didChangeDependencies() async {
    if (!loading_finished) {
      try {
        if (await service.load()) {
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

  @override
  Widget build(BuildContext context) {
    if (!loading_finished) {
      return spinkit1;
    }

    return Tabs();
  }
}

class Tabs extends StatefulWidget {
  Tabs({
    Key key,
  }) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Text(
      'Index 1: PDF',
      style: optionStyle,
    ),
    Text(
      'Index 2: History',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter OCR'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                gap: 0,
                activeColor: Colors.white,
                iconSize: 36,
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 5),
                duration: Duration(milliseconds: 800),
                //tabBackgroundColor: Colors.grey[400],
                tabBackgroundColor: Colors.purple,
                //backgroundColor: Colors.purple,
                color: Colors.purple,
                tabs: [
                  GButton(
                    //borderRadius: BorderRadius.all(Radius.circular(5)),
                    icon: LineIcons.image,
                    text: 'Image',
                  ),
                  GButton(
                    //borderRadius: BorderRadius.all(Radius.circular(5)),
                    icon: LineIcons.file_pdf_o,
                    text: 'PDF',
                  ),
                  GButton(
                    icon: LineIcons.history,
                    text: 'History',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void do_the_scan() async {
    var text = await service.scan(file_path);
    print(text);
    setState(() {
      detected_text = text;
      wating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget left_part_widget;

    left_part_widget = Text(
      'You can click the right bottom button to select an image to start your OCR journey.',
    );

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
