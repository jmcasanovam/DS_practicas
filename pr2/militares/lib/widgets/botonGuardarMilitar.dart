import 'package:flutter/material.dart';

class BotonGuardarMilitar extends StatelessWidget {
  String rango;
  String nombre;
  int equipo;
  Function _guardarMilitar;

  BotonGuardarMilitar({super.key, required this.rango, required this.nombre, required this.equipo, required Function guardarMilitar}) 
    : _guardarMilitar = guardarMilitar {
    _guardarMilitar = guardarMilitar;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _guardarMilitar(nombre, rango == 'O', equipo);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 1, 193, 11),
      ),
      child: const Text('Añadir militar a Equipo 1',
          style: TextStyle(height: 4, fontSize: 20, color: Colors.black)),
    );
  }
}
