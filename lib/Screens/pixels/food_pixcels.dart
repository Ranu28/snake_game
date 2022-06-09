import 'package:flutter/material.dart';

class FoodPixels extends StatefulWidget {
  const FoodPixels({Key? key}) : super(key: key);

  @override
  State<FoodPixels> createState() => _FoodPixelsState();
}

class _FoodPixelsState extends State<FoodPixels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
    );
  }
}
