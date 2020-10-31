import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'main.dart';
import 'models.dart';

class PDFPage extends StatefulWidget {
  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final pdfPageModel = Provider.of<PDFPageModel>(context, listen: true);
    final _images = pdfPageModel.images;

    final appModel = Provider.of<AppModel>(context, listen: false);
    final imagePageModel = Provider.of<ImagePageModel>(context, listen: false);
    final historyPageModel =
        Provider.of<HistoryPageModel>(context, listen: false);

    return Scaffold(
      backgroundColor: _images.isEmpty ? Colors.white : Colors.grey[400],
      body: Center(
          child: _images.isNotEmpty
              ? new StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: _images.length,
                  itemBuilder: (BuildContext context, int index) =>
                      new Container(
                          color: Colors.grey[200],
                          child: new Center(
                            child: GestureDetector(
                              onTap: () async {
                                appModel.tab_index = 0;
                                appModel.do_a_scan(_images[index], appModel,
                                    imagePageModel, historyPageModel);
                              },
                              child: Image.file(new File(_images[index]),
                                  fit: BoxFit.fill),
                            ),
                          )),
                  //staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, 2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                )
              : const Text(
                  'You can click the right bottom button to select an PDF file to start your OCR journey.',
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // show a dialog to open a file
          try {
            FilePickerCross myFile = await FilePickerCross.importFromStorage(
              type: FileTypeCross
                  .any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
            );
            print(myFile.fileName);
            print(myFile.path);
            appModel.ui_loading = true;
            await pdfPageModel.set_pdf_path(myFile.path);
            appModel.ui_loading = false;
          } catch (e) {
            print(e);
          }
        },
        tooltip: 'Add files',
        child: Icon(Icons.add),
      ),
    );
  }
}
