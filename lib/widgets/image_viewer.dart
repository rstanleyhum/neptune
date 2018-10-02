import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String filepath;

  ImageViewer({
    Key key,
    this.filepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: Image.file(File(filepath)).image,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: 4.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
        mini: true,
        child: Icon(Icons.cancel),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
