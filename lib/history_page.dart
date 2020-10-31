import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

import 'main.dart';
import 'models.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('OCR Results has been copyed to clipboard'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getListView(BuildContext context, List<History> lists) {
    final historyPageModel =
        Provider.of<HistoryPageModel>(context, listen: false);

    lists = new List.from(lists.reversed);

    return Container(
      child: lists.isNotEmpty
          ? ListView.builder(
              reverse: false,
              shrinkWrap: true,
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    title: GestureDetector(
                      child: Text('${lists[index].imagePath}'),
                      onTap: () {
                        FlutterClipboard.copy(lists[index].results)
                            .then((value) => print('copied'));
                        _showMyDialog(lists[index].results);
                      },
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.delete),
                      onPressed: () {
                        historyPageModel
                            .remove_one_from_history_list(lists[index]);
                      },
                    ),
                  ),
                );
              },
            )
          : Center(child: const Text('No history yet')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyPageModel =
        Provider.of<HistoryPageModel>(context, listen: true);
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: getListView(context, historyPageModel.history_list)),
      )),
    );
  }
}
