import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import 'main.dart';
import 'models.dart';

class ImagePage extends StatefulWidget {
  ImagePage({
    Key key,
  }) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget left_part_widget;

    final myModel = Provider.of<ImagePageModel>(context, listen: false);
    final historyPageModel =
        Provider.of<HistoryPageModel>(context, listen: false);

    left_part_widget = Text(
      'You can click the right bottom button to select an image to start your OCR journey.',
    );

    if (myModel.image_path != "") {
      left_part_widget = Image.file(new File(myModel.image_path));
    }

    return Consumer<AppModel>(builder: (context, appModel, child) {
      return Consumer<ImagePageModel>(
          builder: (context, imagePageModel, child) {
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
                        controller: imagePageModel.input_controller,
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
                FilePickerCross myFile =
                    await FilePickerCross.importFromStorage(
                  type: FileTypeCross
                      .image, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
                );
                print(myFile.fileName);
                print(myFile.path);
                await appModel.do_a_scan(
                    myFile.path, appModel, imagePageModel, historyPageModel);
              } catch (e) {
                print(e);
              }
            },
            tooltip: 'Add files',
            child: Icon(Icons.add),
          ),
        );
      });
    });
  }
}
