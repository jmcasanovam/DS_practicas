import 'package:flutter/material.dart';

class SubtituloEquipo extends StatelessWidget {
  final String equipo;
  const SubtituloEquipo({super.key, required this.equipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center, // Alineación central
      child: Text(
        "| EQUIPO $equipo |",
        style: const TextStyle(
          fontSize: 30, // Tamaño de la letra
          fontWeight: FontWeight.bold, // Negrita
        ),
      ),
    );
  }
}
