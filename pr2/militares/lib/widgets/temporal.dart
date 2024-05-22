import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tarea.dart';

class GestorDeTareas {
  List<Tarea> mistareas = [];
  final String apiUrl = "http://localhost:3000/tareas";

  GestorDeTareas(this.mistareas);

  Future<void> cargarTareas(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> tareasJson = json.decode(response.body);

      mistareas.clear();
      mistareas.addAll(tareasJson.map((json) => Tarea.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> agregar(Tarea tarea) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tarea.toJson()),
    );
    if (response.statusCode == 201) {
      mistareas.add(Tarea.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add task: ${response.body}');
    }
  }

  Future<void> eliminar(Tarea tarea) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/${tarea.id}'),
    );
    if (response.statusCode == 200) {
      mistareas.removeWhere((t) => t.id == tarea.id);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> marcarCompletada(Tarea tarea) async {
    bool nuevoEstadoCompletado = !(tarea.completada ?? false);

    final response = await http.patch(
      Uri.parse('$apiUrl/${tarea.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'completada': nuevoEstadoCompletado,
      }),
    );

    if (response.statusCode == 200) {
      tarea.completada = nuevoEstadoCompletado;
    } else {
      throw Exception('Failed to update task');
    }
  }
}
