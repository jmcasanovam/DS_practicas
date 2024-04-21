import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  const Titulo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "[ CREACIÓN DE EQUIPOS ]",
      style: TextStyle(
        fontSize: 50, // Tamaño de la letra
        fontWeight: FontWeight.bold, // Negrita
      ),
    );
  }
}
