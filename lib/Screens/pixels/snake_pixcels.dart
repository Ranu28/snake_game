import 'package:flutter/material.dart';

class SnackPixels extends StatefulWidget {
  const SnackPixels({Key? key}) : super(key: key);

  @override
  State<SnackPixels> createState() => _SnackPixelsState();
}

class _SnackPixelsState extends State<SnackPixels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
    );
  }
}
