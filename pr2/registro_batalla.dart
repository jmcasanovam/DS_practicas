import 'package:flutter/material.dart';
// import 'package:militares/ataque.dart';
import 'package:flutter_application_1/militares/gestor.dart';

class Militar {
  String nombre;
  bool esOficial;
  Militar? superior;

  Militar(this.nombre, this.esOficial);

  void asignarSuperior(Militar superior) {
    this.superior = superior;
  }

  String get nombreSuperior => superior?.nombre ?? 'Ninguno';
}

class RegistroBatalla extends StatefulWidget {
  const RegistroBatalla({super.key});

  @override
  State<RegistroBatalla> createState() => _RegistroBatallaState();
}

class _RegistroBatallaState extends State<RegistroBatalla> {
  Gestor gestorBatalla = Gestor(); //Declaramos un gestor que contiene ambos equipos
  final List<Militar> listaMilitares = [];
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _superiorController = TextEditingController();
  String _rango = 'O';
  Future<Militar?>? _superiorSeleccionado;

  @override
  Widget build(BuildContext context) {
    listaMilitares.add(Militar('Juan', true));
    listaMilitares.add(Militar('Pedro', false));
    listaMilitares.add(Militar('Luis', true));
    listaMilitares.add(Militar('Maria', false));
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
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                        labelText: 'Nombre del militar',
                        hintText: 'Don Quijote'),
                  ),
                ),
                const SizedBox(width: 50),
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
              const SizedBox(height: 30),
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
                  _imprimirJerarquia();
                },
                
                child: const Text('Mostrar jeraquia',
                    style: TextStyle(
                        height: 4, fontSize: 20, color: Colors.black)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _guardarMilitar(_nombreController.text, _rango == 'O'); // Guardar el militar
                },
                
                child: const Text('Añadir militar',
                    style: TextStyle(
                        height: 4, fontSize: 20, color: Colors.black)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String log = "Ha ganado el equipo: AB"; //Modificar: que imprima el resultado de la batalla
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

  void _guardarMilitar(String nombre, bool esOficial) {
    // Guardar el militar en la lista
    setState(() {
      listaMilitares.add(Militar(_nombreController.text, esOficial));
    });
    _rango = 'O';
    _nombreController.clear();
    _superiorController.clear();
  }

  Future<Militar?> _mostrarOficiales() async {
    List<Militar> oficiales = [];
    for (Militar militar in listaMilitares) {
      if (militar.esOficial) {
        oficiales.add(militar);
      }
    }

    // Mostrar la lista de oficiales
    final seleccionado = await showDialog<Militar?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'Esta es la lista de oficiales. Selecciona a que oficial quieres agregarlo:'),
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

  void _imprimirJerarquia() {
    String texto = 'oficial1.imprimirJerarquia';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Jerarquía de militares'),
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
          title: const Text('***** RESULTADO DE LA BATALLA *****', textAlign: TextAlign.center,),
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

