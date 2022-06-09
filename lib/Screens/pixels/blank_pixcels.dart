import 'package:flutter/material.dart';

class BlankPixels extends StatefulWidget {
  const BlankPixels({Key? key}) : super(key: key);

  @override
  State<BlankPixels> createState() => _BlankPixcelsState();
}

class _BlankPixcelsState extends State<BlankPixels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(4)),
    );
  }
}
