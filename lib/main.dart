import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:desktop_window/desktop_window.dart';

import 'package:provider/provider.dart';

import 'server.dart';
import 'database.dart';
import 'models.dart';
import 'little_widgets.dart';
import 'image_page.dart';

final service = Service();
final database = Database();

Future<void> main(List<String> args) async {
  await database.init();

  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(Size(960, 640));

  service.say_hi();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppModel()),
      ChangeNotifierProvider(create: (context) => ImagePageModel()),
    ],
    child: MaterialApp(
      title: 'Flutter OCR',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyApp(),
    ),
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
    ImagePage(),
    Text(
      'PDF',
      style: optionStyle,
    ),
    Text(
      'History',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, appModel, child) {
      if (appModel.ui_loading) {
        return spinkit2;
      }

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
    });
  }
}
