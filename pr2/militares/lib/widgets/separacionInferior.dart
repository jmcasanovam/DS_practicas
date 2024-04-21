import 'package:flutter/material.dart';

class SeparacionInferior extends StatelessWidget {
  double height;
  SeparacionInferior({super.key, this.height = 7});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}