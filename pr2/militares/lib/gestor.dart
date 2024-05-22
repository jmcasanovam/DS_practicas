import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'militar.dart';
import 'ataque.dart';

class Gestor {
  late Oficial jefe1;
  late Oficial jefe2;
  int e1vivos = -1;
  int e2vivos = -1;
  String registro = ""; //Lo que se muestra cuando se acaba la partida (log)
  bool fin = false;
  late bool empiezaEq1;

  final String apiUrl = "http://localhost:3000/militars";
  List<Militar> misMilitares = [];

  Gestor() {
    jefe1 = Oficial("Capitan equipo1");
    jefe2 = Oficial("Capitan equipo2");
  }

  void equipo1setAtaque() {
    jefe1.setAtaque(devolverAtaqueRandom());
  }

  void equipo2setAtaque() {
    jefe2.setAtaque(devolverAtaqueRandom());
  }

  void equipo1ataca() {
    registro += jefe1.atacar(jefe2);
    equipo2vivos();
    registro +=
        "-----El equipo 1 ha hecho un ${jefe1.ataque.totxt()} al equipo 2. Quedan $e2vivos militares en pie del equipo 2\n";
  }

  void equipo2ataca() {
    registro += jefe2.atacar(jefe1);
    equipo1vivos();
    registro +=
        ">>>>>El equipo 2 ha hecho un ${jefe2.ataque.totxt()} al equipo 1. Quedan $e1vivos militares en pie del equipo 1\n";
  }

  Ataque devolverAtaqueRandom() {
    int r = Random().nextInt(3);

    if (r == 0) {
      return AtaqueAereo();
    } else if (r == 1) {
      return AtaqueMaritimo();
    } else {
      return AtaqueTerrrestre();
    }
  }

  void equipo1vivos() {
    e1vivos = jefe1.cantidadVivos();
  }

  void equipo2vivos() {
    e2vivos = jefe2.cantidadVivos();
  }

  bool partidaFinalizada() {
    fin = e1vivos == 0 || e2vivos == 0;
    return fin;
  }

  int ganador() {
    if (fin) {
      if (e1vivos == 0) {
        return 2;
      } else {
        return 1;
      }
    } else {
      return 0;
    }
  }

  void comenzarBatalla() {
    int i = Random().nextInt(2);
    empiezaEq1 = i == 0 ? true : false;
    while (!partidaFinalizada()) {
      if (i % 2 == 0) {
        equipo1setAtaque();
        equipo1ataca();
      } else {
        equipo2setAtaque();
        equipo2ataca();
      }
      i++;
    }
  }

  String getRegistro() {
    return registro;
  }

  List<Militar> getOficiales1() {
    return jefe1.getOficiales();
  }

  List<Militar> getOficiales2() {
    return jefe2.getOficiales();
  }

  List<Militar> getRasos1() {
    return jefe1.getRasos();
  }

  List<Militar> getRasos2() {
    return jefe2.getRasos();
  }

  List<Militar> getMilitares1() {
    List<Militar> junta = jefe1.getOficiales();
    List<Militar> rasos = jefe1.getRasos();
    junta.addAll(rasos);
    return junta;
  }

  List<Militar> getMilitares2() {
    List<Militar> junta = jefe2.getOficiales();
    List<Militar> rasos = jefe2.getRasos();
    junta.addAll(rasos);
    return junta;
  }

  void convertirAOficial1(Raso r) {
    bool encontrado = false;
    for (Militar oficial in getOficiales1()) {
      for (Militar raso in (oficial as Oficial).militares) {
        if (raso == r) {
          Oficial nuevo = Oficial(r.nombre);
          nuevo.ataque = r.ataque;
          nuevo.vida = r.vida * 1.5;
          oficial.militares.remove(raso);
          oficial.militares.add(nuevo);
          encontrado = true;
          break;
        }
      }
      if (encontrado) break;
    }
  }

  void convertirAOficial2(Raso r) {
    bool encontrado = false;
    for (Militar oficial in getOficiales2()) {
      for (Militar raso in (oficial as Oficial).militares) {
        if (raso == r) {
          Oficial nuevo = Oficial(r.nombre);
          nuevo.ataque = r.ataque;
          nuevo.vida = r.vida * 1.5;
          oficial.militares.remove(raso);
          oficial.militares.add(nuevo);
          encontrado = true;
          break;
        }
      }
      if (encontrado) break;
    }
  }

  void cambiarNombre(Militar m, String nombre) {
    m.nombre = nombre;
  }

  void eliminarMilitar1(Militar m) {
    bool encontrado = false;
    for (Militar oficial in getOficiales1()) {
      for (Militar hijo in (oficial as Oficial).militares) {
        if (hijo == m) {
          hijo.eliminarHijos();
          oficial.militares.remove(hijo);
          encontrado = true;
          break;
        }
      }
      if (encontrado) break;
    }
  }

  void eliminarMilitar2(Militar m) {
    bool encontrado = false;
    for (Militar oficial in getOficiales2()) {
      for (Militar hijo in (oficial as Oficial).militares) {
        if (hijo == m) {
          hijo.eliminarHijos();
          oficial.militares.remove(hijo);
          encontrado = true;
          break;
        }
      }
      if (encontrado) break;
    }
  }

  Future<void> cargarMilitares1(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> militaresJson = json.decode(response.body);

      misMilitares.clear();
      misMilitares
          .addAll(militaresJson.map((json) => Militar.fromJson(json)).toList());
      misMilitares = misMilitares;
      misMilitares.add(Raso("Lucas"));
      misMilitares = misMilitares;
      print(misMilitares);
    } else {
      throw Exception('Failed to load militars');
    }
  }

  Future<void> agregar(Militar militar, String nombrepadre) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(militar.toJson(nombrepadre)),
    );
    if (response.statusCode == 201) {
      for (Militar oficial in getOficiales1()) {
        if (oficial.nombre == nombrepadre) {
          oficial.agregar(Militar.fromJson(json.decode(response.body)));
        }
      }
      misMilitares.add(Militar.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add militar: ${response.body}');
    }
  }

  Future<void> eliminar(String nombre, String usuario) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/militars?usuario=$usuario&nombre=$nombre'),
    );
    if (response.statusCode == 200) {
      misMilitares.removeWhere((t) => t.nombre == nombre);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> actualizarMilitar(
      Militar militar, Militar nuevoMilitar, String usuario) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/militars?usuario=$usuario&nombre=$militar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(nuevoMilitar.toJson("")),
    );

    if (response.statusCode == 200) {
      // habria que actualizar el militar en la lista
    } else {
      throw Exception('Failed to update task');
    }
  }
}
