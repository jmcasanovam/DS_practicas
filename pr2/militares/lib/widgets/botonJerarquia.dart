import 'package:flutter/material.dart';

class BotonJerarquia extends StatelessWidget {
  Function function;
  int? _equipo;
  Color _color = Colors.blue;
  String _texto = '';

  BotonJerarquia(
      {super.key,
      required this.function,
      int? equipo,
      Color? color,
      String? texto}) {
    if (equipo != null) {
      _equipo = equipo;
    }
    if (color != null) {
      _color = color;
    }
    if (texto != null) {
      _texto = texto;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
          function(_equipo);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _color,
      ),
      child: Text(_texto,
          style: const TextStyle(height: 4, fontSize: 20, color: Colors.black)),
    );
  }
}
