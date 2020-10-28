import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

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
