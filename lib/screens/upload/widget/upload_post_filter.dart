import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../screens_export.dart';

class ImageFiltterEditing extends StatelessWidget {
  final Uint8List image;
  const ImageFiltterEditing({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.memory(
          image,
          width: screenWidth,
          height: screenHeight * .45,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
