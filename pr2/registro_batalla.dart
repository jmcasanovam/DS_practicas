import 'package:flutter/material.dart';
import 'package:militares/ataque.dart';
import 'package:militares/gestor.dart';
import 'package:militares/militar.dart';

class RegistroBatalla extends StatefulWidget {
  const RegistroBatalla({super.key});

  @override
  State<RegistroBatalla> createState() => _RegistroBatallaState();
}

class _RegistroBatallaState extends State<RegistroBatalla> {
  Gestor gestorBatalla = Gestor(); //Declaramos un gestor que contiene ambos equipos

  // Controladores de texto para los campos de nombre del militar y ofical seleccionado
  TextEditingController _nombreController = TextEditingController(); // Para el quipo 1
  TextEditingController _superiorController = TextEditingController();
  TextEditingController _nombreController2 = TextEditingController(); // Para el quipo 2
  TextEditingController _superiorController2 = TextEditingController();

  // Cadenas auxiliares para pasar un parámetro booleano a la funcion guardarMilitar
  String _rango = 'O';
  String _rango2 = 'O';

  // Seleccion de militares de cada equipo
  Future<Militar?>? _superiorSeleccionado;
  Future<Militar?>? _superiorSeleccionado2;

  @override
  Widget build(BuildContext context) {
    // Definicion de los militares por defecto para el equipo 1
    gestorBatalla.getOficiales1()[0].agregar(Oficial("oficial1"));
    gestorBatalla.getOficiales1()[1].agregar(Oficial("oficial2"));
    gestorBatalla.getOficiales1()[0].agregar(Raso("raso1"));
    gestorBatalla.getOficiales1()[1].agregar(Raso("raso2"));
    gestorBatalla.getOficiales1()[2].agregar(Raso("raso3"));
    gestorBatalla.getOficiales1()[2].agregar(Oficial("oficial3"));
    gestorBatalla.getOficiales1()[3].agregar(Oficial("oficial4"));
    gestorBatalla.getOficiales1()[2].agregar(Oficial("oficial5"));

    // Definicion de los militares por defecto para el equipo 2
    gestorBatalla.getOficiales2()[0].agregar(Oficial("oficial1"));
    gestorBatalla.getOficiales2()[1].agregar(Oficial("oficial2"));
    gestorBatalla.getOficiales2()[0].agregar(Raso("raso1"));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('** RESGISTRO DE BATALLA **'),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                                    50), //para dejar un espacio entre los campos
                            Expanded(
                              child: TextField(
                                controller: _superiorController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                    labelText: 'Superior Seleccionado',
                                    hintText: 'Selecciona un superior'),
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
                                          _superiorSeleccionado!.then((value) {
                                            _superiorController.text =
                                                value?.nombre ?? 'Ninguno';
                                          });
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 36, 30, 206),
                                      ),
                                      child: const Text(
                                          'Seleccionar oficial superior',
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _imprimirJerarquia(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 193, 183, 1),
                            ),
                            child: const Text('Mostrar jeraquia del Equipo 1',
                                style: TextStyle(
                                    height: 4,
                                    fontSize: 20,
                                    color: Colors.black)),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_superiorController.text.isNotEmpty) {
                                _guardarMilitar(_nombreController.text,
                                    _rango == 'O'); // Guardar el militar
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 193, 11),
                            ),
                            child: const Text('Añadir militar a Equipo 1',
                                style: TextStyle(
                                    height: 4,
                                    fontSize: 20,
                                    color: Colors.black)),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    //////////// ESPACIO ENTRE EQUIPOS ////////////
                    const SizedBox(width: 50),

                    //////////// EQUIPO 2 ////////////
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                                    50), //para dejar un espacio entre los campos
                            Expanded(
                              child: TextField(
                                controller: _superiorController2,
                                readOnly: true,
                                decoration: const InputDecoration(
                                    labelText: 'Superior Seleccionado',
                                    hintText: 'Selecciona un superior'),
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
                                          _superiorSeleccionado2!.then((value) {
                                            _superiorController2.text =
                                                value?.nombre ?? 'Ninguno';
                                          });
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 36, 30, 206),
                                      ),
                                      child: const Text(
                                          'Seleccionar oficial superior',
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
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _imprimirJerarquia(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 193, 183, 1),
                            ),
                            child: const Text('Mostrar jeraquia del Equipo 2',
                                style: TextStyle(
                                    height: 4,
                                    fontSize: 20,
                                    color: Colors.black)),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _guardarMilitar(_nombreController2.text,
                                  _rango2 == 'O'); // Guardar el militar
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 193, 11),
                            ),
                            child: const Text('Añadir militar a Equipo 2',
                                style: TextStyle(
                                    height: 4,
                                    fontSize: 20,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              //////////// BOTON BATALLA ////////////
              
              ElevatedButton(
                onPressed: () {
                  _batalla();
                  String equipo_ganador = "Ha ganado el equipo: ${gestorBatalla.ganador()}\n"; 
                  String log = gestorBatalla.getRegistro();
                  _imprimirResultadoBatalla(log, equipo_ganador);
                },
                child: const Text(' COMENZAR BATALLA ',
                style: TextStyle(height: 4, fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              //////////// ESPACIO PARA POSICIONAR EL BOTON ////////////
              //const SizedBox(height: 200),

            ],
          ),
        ),
      ),
    );
  }


/////////////////////////////////////////////////////////////////////////////////////
  void _batalla(){
    int i=0;
    while(!gestorBatalla.partidaFinalizada()){
      if(i%2==0){
      //   print("equipo 1 ataca");
      //   print("quedan ${gestorBatalla.e2vivos} vivos del equipo 2");
      //  print("Vida del jefe del equipo 2: ${gestorBatalla.jefe2.vida}");
        gestorBatalla.equipo1setAtaque();
        gestorBatalla.equipo1ataca();
      }
      else{
        // print("equipo 2 ataca");
        // print("Vida del jefe del equipo 1: ${gestorBatalla.jefe1.vida}");
        gestorBatalla.equipo2setAtaque();
        gestorBatalla.equipo2ataca();
      }
      i++;
    }
  }

  void _guardarMilitar(String nombre, bool esOficial) {
    // Guardar el militar en la lista
    if (nombre.isNotEmpty) {
      setState(() {
        _superiorSeleccionado!.then((value) {
          if (value != null) {
            if (esOficial) {
              value.agregar(Oficial(nombre));
            } else {
              value.agregar(Raso(nombre));
            }
          }
        });

        //gestorBatalla.getOficiales1();
      });
      _rango = 'O';
      _nombreController.clear();
      _superiorController.clear();
    }
    else {
      print("esta vacio");
    }
  }

  Future<Militar?> _mostrarOficiales(int numEquipo) async {
    print("Mostrar ${gestorBatalla.jefe1.militares.length}");

    List<Militar> oficiales;
    numEquipo == 1
        ? oficiales = gestorBatalla.getOficiales1()
        : oficiales = gestorBatalla.getOficiales2();

    final seleccionado = await showDialog<Militar?>(
      context: context,
      builder: (BuildContext context) {
        debugPrint("Primero ${gestorBatalla.jefe1.militares.length}");

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
                    print("ontap1 ${gestorBatalla.jefe1.militares.length}");

                    Navigator.of(context).pop(
                        oficiales[index]); //Devolver el militar seleccionado
                    print("ontap2 ${gestorBatalla.jefe1.militares.length}");
                  },
                );
              },
            ),
          ),
        );
      },
    );
    oficiales.clear();

    print("Fin mostar ${gestorBatalla.jefe1.militares.length}");

    return seleccionado;
  }

  void _imprimirJerarquia(int equipo) {
    // String texto = 'oficial1.imprimirJerarquia';
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



content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: oficiales.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(oficiales[index].nombre),
                  onTap: () {
                    print("ontap1 ${gestorBatalla.jefe1.militares.length}");

                    Navigator.of(context).pop(
                        oficiales[index]); //Devolver el militar seleccionado
                    print("ontap2 ${gestorBatalla.jefe1.militares.length}");
                  },
                );
              },
            ),
          ),
