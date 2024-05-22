import 'package:flutter/material.dart';
import 'package:militares/gestor.dart';
import 'package:militares/militar.dart';
import 'package:militares/widgets/botonGuardarMilitar.dart';
import 'package:militares/widgets/botonJerarquia.dart';
import 'package:militares/widgets/separacionInferior.dart';
import 'package:militares/widgets/subtituloEquipo.dart';
import '../widgets/titulo.dart';
import 'dart:math';

class RegistroBatalla extends StatefulWidget {
  const RegistroBatalla({super.key});

  @override
  State<RegistroBatalla> createState() => _RegistroBatallaState();
}

class _RegistroBatallaState extends State<RegistroBatalla> {
  Gestor gestorBatalla =
      Gestor(); //Declaramos un gestor que contiene ambos equipos

  // Controladores de texto para los campos de nombre del militar y ofical seleccionado
  TextEditingController _nombreController =
      TextEditingController(); // Para el quipo 1
  TextEditingController _superiorController = TextEditingController();
  TextEditingController _nombreController2 =
      TextEditingController(); // Para el quipo 2
  TextEditingController _superiorController2 = TextEditingController();

  // Cadenas auxiliares para pasar un parámetro booleano a la funcion guardarMilitar
  String _rango = 'O';
  String _rango2 = 'O';

  // Seleccion de militares de cada equipo
  Future<Militar?>? _superiorSeleccionado;
  Future<Militar?>? _superiorSeleccionado2;

  // Lista de usuarios(BASE DE DATOS??????)
  String currentUser = "Jose";
  String currentUser2 = "Alvaro";
  List<String> users = ["Alvaro", "Ruben", "David", "Jose"];

  @override
  void initState() {
    _cargarEquipo1(currentUser);
    _cargarEquipo2(currentUser2);
  }

  _cargarEquipo1(String nombre) async {
    try {
      await gestorBatalla.cargarMilitares1(nombre);
      setState(() {
        // gestorBatalla.jefe1.militares = gestorBatalla.jefe1.militares;
      });
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }



  _cargarEquipo2(String nombre) async {
    try {
      await gestorBatalla.cargarMilitares2(nombre);
      setState(() {
        // gestorBatalla.jefe2.militares = gestorBatalla.jefe2.militares;
      });
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center, // Alineación central
            child: const Titulo(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    //////////// EQUIPO 1 ////////////
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Flexible(
                              fit: FlexFit.tight,
                              flex: 0,
                              child: SubtituloEquipo(equipo: '1'),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextField(
                                  controller: _nombreController,
                                  decoration: const InputDecoration(
                                      labelText: 'Nombre del militar',
                                      hintText: 'ej. Sargento Casanova'),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      30), //para dejar un espacio entre los campos
                              Expanded(
                                child: TextField(
                                  controller: _superiorController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Superior Seleccionado',
                                      hintText: 'Selecciona un superior'),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: currentUser,
                                  icon: const Icon(Icons.face),
                                  onChanged: (String? newValue) {
                                    setState((){
                                      currentUser = newValue!;
                                      _cargarEquipo1(currentUser);
                                    });
                                  },
                                  items: users.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )
                            ]),
                            const SizedBox(
                                height:
                                    30), //espacio inferior de los campos de texto
                            ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: const Text('Oficial'),
                                            leading: Radio<String>(
                                              value: 'O',
                                              groupValue: _rango,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _rango = value!;
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Raso'),
                                            leading: Radio<String>(
                                              value: 'R',
                                              groupValue: _rango,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _rango = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Mostrar la lista de oficiales
                                          setState(() {
                                            _superiorSeleccionado =
                                                _mostrarOficiales(1);
                                            _superiorSeleccionado!
                                                .then((value) {
                                              _superiorController.text =
                                                  value?.nombre ?? '';
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 36, 30, 206),
                                        ),
                                        child: const Text(
                                            'Seleccionar oficial superior (1)',
                                            style: TextStyle(
                                                height: 4,
                                                fontSize: 20,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SeparacionInferior(),
                            BotonJerarquia(
                                function: _imprimirJerarquia,
                                equipo: 1,
                                color: const Color.fromARGB(255, 193, 183, 1),
                                texto: 'Mostrar jerarquía del Equipo 1'),
                            SeparacionInferior(),
                            BotonGuardarMilitar(
                              rango: _rango,
                              nombre: _nombreController.text,
                              equipo: 1,
                              guardarMilitar: _guardarMilitar,
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                // Mostrar la lista de militares
                                setState(() {
                                  _superiorSeleccionado = _mostrarMilitares(1); //CAMBIAR IMPLEMENTACIÓN
                                  _superiorSeleccionado!.then((value) {
                                    funcionActualizar(1, value);
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 15, 238, 190),
                              ),
                              child: const Text(
                                  'Actualizar Militar del equipo 1',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                // Mostrar la lista de militares y ELIMINA un militar
                                setState(() {
                                  _superiorSeleccionado = _mostrarMilitares(1);
                                  _superiorSeleccionado!.then((value) {
                                    gestorBatalla.eliminar1(value!.nombre, currentUser);
                                    _superiorController2.text = '';
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 66, 66),
                              ),
                              child: const Text('Eliminar Militar del equipo 1',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 66, 164, 255),
                              ),
                              child: const Text('GUARDAR EQUIPO EN BD',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //////////// ESPACIO ENTRE EQUIPOS ////////////
                    const SizedBox(width: 50),

                    //////////// EQUIPO 2 ////////////
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Flexible(
                              fit: FlexFit.tight,
                              flex: 0,
                              child: SubtituloEquipo(equipo: '2'),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextField(
                                  controller: _nombreController2,
                                  decoration: const InputDecoration(
                                      labelText: 'Nombre del militar',
                                      hintText: 'ej. Sargento Casanova'),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      30), //para dejar un espacio entre los campos
                              Expanded(
                                child: TextField(
                                  controller: _superiorController2,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Superior Seleccionado',
                                      hintText: 'Selecciona un superior'),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: currentUser2,
                                  icon: const Icon(Icons.face),
                                  onChanged: (String? newValue) {
                                    setState((){
                                      currentUser2 = newValue!;
                                      /*  _cargarEjercitoDelUsuario(currentUser); */
                                      _cargarEquipo2(currentUser2);
                                    });
                                  },
                                  items: users.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )
                            ]),
                            const SizedBox(
                                height:
                                    30), //espacio inferior de los campos de texto
                            ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: const Text('Oficial'),
                                            leading: Radio<String>(
                                              value: 'O',
                                              groupValue: _rango2,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _rango2 = value!;
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Raso'),
                                            leading: Radio<String>(
                                              value: 'R',
                                              groupValue: _rango2,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _rango2 = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Mostrar la lista de oficiales
                                          setState(() {
                                            _superiorSeleccionado2 =
                                                _mostrarOficiales(2);
                                            _superiorSeleccionado2!
                                                .then((value) {
                                              _superiorController2.text =
                                                  value?.nombre ?? '';
                                            });
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 36, 30, 206),
                                        ),
                                        child: const Text(
                                            'Seleccionar oficial superior (2)',
                                            style: TextStyle(
                                                height: 4,
                                                fontSize: 20,
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SeparacionInferior(),
                            BotonJerarquia(
                                function: _imprimirJerarquia,
                                equipo: 2,
                                color: const Color.fromARGB(255, 193, 183, 1),
                                texto: 'Mostrar jerarquía del Equipo 2'),
                            SeparacionInferior(),
                            BotonGuardarMilitar(
                              rango: _rango2,
                              nombre: _nombreController2.text,
                              equipo: 2,
                              guardarMilitar: _guardarMilitar,
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                // Mostrar la lista de militares
                                setState(() {
                                  _superiorSeleccionado2 = _mostrarMilitares(2); //CAMBIAR IMPLEMENTACIÓN
                                  _superiorSeleccionado2!.then((value) {
                                    funcionActualizar(2, value);
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 15, 238, 190),
                              ),
                              child: const Text(
                                  'Actualizar Militar del equipo 2',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                // Mostrar la lista de militares y ELIMINA un militar
                                setState(() {
                                  _superiorSeleccionado2 = _mostrarMilitares(2);
                                  _superiorSeleccionado2!.then((value) {
                                    gestorBatalla.eliminar2(value!.nombre, currentUser2);
                                    _superiorController2.text = '';
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 66, 66),
                              ),
                              child: const Text('Eliminar Militar del equipo 2',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                            SeparacionInferior(),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  //FUNCIONALIDAD
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 66, 164, 255),
                              ),
                              child: const Text('GUARDAR EQUIPO EN BD',
                                  style: TextStyle(
                                      height: 4,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //////////// BOTON BATALLA ////////////
              ElevatedButton(
                onPressed: () {
                  gestorBatalla.comenzarBatalla();
                  String equipoGanador =
                      "Ha ganado el equipo de ${gestorBatalla.ganador() == 1 ? currentUser : currentUser2}: ${gestorBatalla.ganador()}  \n";
                  String log = gestorBatalla.getRegistro();
                  _imprimirResultadoBatalla(log, equipoGanador);
                },
                child: const Text(' COMENZAR BATALLA ',
                    style: TextStyle(
                        height: 4,
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////
  
  void funcionActualizar(int equipo, Militar? value) async{
    if(equipo==1){
      String padre="";
      bool encontrado=false;
      for (Militar oficial in gestorBatalla.getOficiales1()) {
        for (Militar hijo in (oficial as Oficial).militares) {
          if (hijo.nombre == value!.nombre) {
            padre=oficial.nombre;
            encontrado = true;
            break;
          }
        }
        if (encontrado) break;
      }
      await gestorBatalla.actualizarMilitar1(value!.nombre, _nombreController.text, padre, currentUser);
      _nombreController.text = '';
      if( value is Oficial ){
        for(Militar m in value.militares){
          await gestorBatalla.actualizarMilitar1(m.nombre, m.nombre, _nombreController.text, currentUser);
        }
        
      }
      
    }
    else if(equipo==2){
      String padre="";
      bool encontrado=false;
      for (Militar oficial in gestorBatalla.getOficiales2()) {
        for (Militar hijo in (oficial as Oficial).militares) {
          if (hijo.nombre == value!.nombre) {
            padre=oficial.nombre;
            encontrado = true;
            break;
          }
        }
        if (encontrado) break;
      }
      gestorBatalla.actualizarMilitar2(value!.nombre, _nombreController2.text, padre, currentUser2);
      _nombreController2.text = '';
      if( value is Oficial ){
        for(Militar m in value.militares){
          gestorBatalla.actualizarMilitar2(m.nombre, m.nombre, _nombreController2.text, currentUser2);
        }
      }
    }

  }

  void _cargarEquiposIniciales() async {
    try {
      await gestorBatalla.cargarMilitares1("Jose");
      setState(() {
        gestorBatalla.jefe1.militares = gestorBatalla.jefe1.militares;
      });
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  void _guardarMilitar(String nombre, bool esOficial, int numEquipo) {
    if (numEquipo == 1) {
      // Guardar el militar en la lista
      if (nombre.isNotEmpty && _superiorController.text.isNotEmpty) {
        setState(() {
          _superiorSeleccionado!.then((value) {
            if (value != null) {
              if (esOficial) {
                // value.agregar(Oficial(nombre));
                Oficial of = Oficial(nombre);
                of.usuario = currentUser;
                gestorBatalla.agregar1(of, value.nombre);
              } else {
                // value.agregar(Raso(nombre));
                Raso ra = Raso(nombre);
                ra.usuario = currentUser;
                gestorBatalla.agregar1(ra, value.nombre);
              }
            }
          });
        });
        _rango = 'O';
        _nombreController.clear();
        _superiorController.clear();
      } else {
        print("esta vacio");
      }
    } else if (numEquipo == 2) {
      // Guardar el militar en la lista
      if (nombre.isNotEmpty && _superiorController2.text.isNotEmpty) {
        setState(() {
          _superiorSeleccionado2!.then((value) {
            if (value != null) {
              if (esOficial) {
                // value.agregar(Oficial(nombre));
                Oficial of = Oficial(nombre);
                of.usuario = currentUser2;
                gestorBatalla.agregar2(of, value.nombre);
              } else {
                // value.agregar(Raso(nombre));
                Raso ra = Raso(nombre);
                ra.usuario = currentUser2;
                gestorBatalla.agregar2(ra, value.nombre);
              }
            }
          });
        });
        _rango2 = 'O';
        _nombreController2.clear();
        _superiorController2.clear();
      } else {
        print("esta vacio");
      }
    }
  }

  Future<Militar?> _mostrarOficiales(int numEquipo) async {
    List<Militar> oficiales;
    numEquipo == 1
        ? oficiales = gestorBatalla.getOficiales1()
        : oficiales = gestorBatalla.getOficiales2();

    final seleccionado = await showDialog<Militar?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'lista de oficiales. Selecciona a que oficial quieres agregarlo:'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: oficiales.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(oficiales[index].nombre),
                  onTap: () {
                    Navigator.of(context).pop(
                        oficiales[index]); //Devolver el militar seleccionado
                  },
                );
              },
            ),
          ),
        );
      },
    );
    oficiales.clear();

    return seleccionado;
  }

  Future<Militar?> _mostrarMilitares(int numEquipo) async {
    List<Militar> militares;
    numEquipo == 1
        ? militares = gestorBatalla
            .getMilitares1() //MODIFICAR OBTENER TODOS LOS MILITARES, NO SOLO OFICIALES
        : militares = gestorBatalla.getMilitares2();

    final seleccionado = await showDialog<Militar?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Militares del equipo.'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: militares.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(militares[index].nombre),
                  onTap: () {
                    Navigator.of(context).pop(
                        militares[index]); //Devolver el militar seleccionado
                  },
                );
              },
            ),
          ),
        );
      },
    );
    militares.clear();

    return seleccionado;
  }

  void _imprimirJerarquia(int equipo) {
    String texto = "";
    (equipo == 1)
        ? texto = gestorBatalla.getOficiales1()[0].imprimirJerarquia(0)
        : texto = gestorBatalla.getOficiales2()[0].imprimirJerarquia(0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Jerarquía de militares del equipo $equipo'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Text(
                texto,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _imprimirResultadoBatalla(String log, String equipoGanador) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '***** RESULTADO DE LA BATALLA *****',
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    equipoGanador,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    log,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '¡¡¡ FIN DE LA BATALLA !!!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
