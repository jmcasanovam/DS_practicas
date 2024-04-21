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
  Gestor gestorBatalla =
      Gestor(); //Declaramos un gestor que contiene ambos equipos
  // final List<Militar> listaMilitares = [];

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _superiorController = TextEditingController();
  String _rango = 'O';
  Future<Militar?>? _superiorSeleccionado;
  bool mostrandoDialogo = false;

  @override
  Widget build(BuildContext context) {
    // listaMilitares.add(Militar('Juan', true));
    // listaMilitares.add(Militar('Pedro', false));
    // listaMilitares.add(Militar('Luis', true));
    // listaMilitares.add(Militar('Maria', false));

    // gestorBatalla.aniadirJefe1( Oficial('Juan', true,AtaqueAereo()));
    gestorBatalla.getOficiales1()[0].agregar(Oficial("oficial1"));
    gestorBatalla.getOficiales1()[1].agregar(Oficial("oficial2"));
    gestorBatalla.getOficiales1()[0].agregar(Raso("raso1"));
    gestorBatalla.getOficiales1()[1].agregar(Raso("raso2"));
    gestorBatalla.getOficiales1()[2].agregar(Raso("raso3"));
    gestorBatalla.getOficiales1()[2].agregar(Oficial("oficial3"));
    gestorBatalla.getOficiales1()[3].agregar(Oficial("oficial4"));
    gestorBatalla.getOficiales1()[2].agregar(Oficial("oficial5"));

    // gestorBatalla.aniadirJefe1(Oficial("Juan"));
    // gestorBatalla.aniadirJefe1(Oficial("Pedro"));
    // gestorBatalla.aniadirJefe1(Oficial("Luis"));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registro Militar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(children: [

              // ],
              // )
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                        labelText: 'Nombre del militar',
                        hintText: 'ej. Sargento Casanova'),
                  ),
                ),
                const SizedBox(width: 50), //para dejar un espacio entre los campos
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
              const SizedBox(height: 30), //espacio inferior de los campos de texto
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
                              _superiorSeleccionado = _mostrarOficiales();
                              _superiorSeleccionado!.then((value) {
                                _superiorController.text =
                                    value?.nombre ?? 'Ninguno';
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 36, 30, 206),
                          ),
                          child: const Text(
                              'Seleccionar un oficial de la lista de oficiales',
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
                  backgroundColor: const Color.fromARGB(255, 193, 183, 1),
                ),
                child: const Text('Mostrar jeraquia',
                    style: TextStyle(
                        height: 4, fontSize: 20, color: Colors.black)),
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
                  backgroundColor: const Color.fromARGB(255, 1, 193, 11),
                ),
                child: const Text('Añadir militar',
                    style: TextStyle(
                        height: 4, fontSize: 20, color: Colors.black)),
              ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _batalla();
                  String log =
                      "Ha ganado el equipo: AB"; //Modificar: que imprima el resultado de la batalla
                  _imprimirResultadoBatalla(log);
                },
                child: const Text('!! YA ESTA AQUI LA GUERRA BOOM ¡¡',
                    style: TextStyle(
                        height: 4, fontSize: 20, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _batalla(){
    int i=0;
    while(!gestorBatalla.partidaFinalizada()){
      if(i%2==0){
        gestorBatalla.equipo1setAtaque();
        gestorBatalla.equipo1ataca();
      }
      else{
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

  Future<Militar?> _mostrarOficiales() async {
    List<Militar> oficiales = gestorBatalla.getOficiales1();

    for(Militar m in gestorBatalla.getOficiales1()){
      print(m.nombre);
    }
    // Mostrar la lista de oficiales
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
                    Navigator.of(context).pop(oficiales[index]); //Devolver el militar seleccionado
                   
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

  void _imprimirResultadoBatalla(String log) async {
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
              child: Text(
                log,
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
}
