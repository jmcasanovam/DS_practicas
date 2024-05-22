import 'package:flutter_test/flutter_test.dart';
import 'package:militares/screens/registro_batalla.dart';
import 'package:militares/gestor.dart';
import 'package:militares/militar.dart';
import 'package:militares/ataque.dart';
import 'package:flutter/material.dart';

void main() {
  // test("Test agregar", () async{
  //   Gestor gestorBatalla = Gestor();
  //   Oficial of1 = Oficial("of1");
  //   of1.usuario = "Ruben";
  //   await gestorBatalla.agregar(of1, "Capitan equipo1");
  //   Oficial of2 = Oficial("of100");
  //   of2.usuario = "Ruben";
  //   await gestorBatalla.agregar(of2, "Capitan equipo1");

  //   for (Militar m in gestorBatalla.getMilitares1()) {
  //     print("Nombre: ${m.nombre}");
  //   }

  //   print("Numero de oficiales: ${gestorBatalla.getMilitares1().length}");
  //   print(gestorBatalla.getMilitares1());
  //   print("Numero de militares en vector MisMilitares: ${gestorBatalla.misMilitares.length}");
  //   print(gestorBatalla.misMilitares);
    
  // });

  // test("Test Delete", () async {
  //   Gestor gestorBatalla = Gestor();
    
  //   await gestorBatalla.eliminar("of23", "Jose");
  //   await gestorBatalla.eliminar("of24", "Jose");
  // });

  // test("Test Modificar", () {
  //   Gestor gestorBatalla = Gestor();

  //   gestorBatalla.modificar("of11", "Jose", "Capitan equipo1");
  // });

  

  // test("Test cargarmilitar", () async {
  //   Gestor gestorBatalla = Gestor();

  //   await gestorBatalla.cargarMilitares1("Jose");

  //   print("Numero de militares en vector MisMilitares: ${gestorBatalla.misMilitares.length}");
  //   print(gestorBatalla.misMilitares);
    
  // });

  /////////// TESTS DEL GRUPO DE CLASES DEL MODELO ///////////
//   group('GRUPO TESTS DEL MODELO', () {
//     //  clase Militar, Oficial, Raso y Ataque
//     test('Incrementar Array Militares', () {
//       // creamos un oficial y esperamos que al inicio su array de militares tenga 0 elementos y despues de agregar uno tengo 1
//       Oficial oficial_base = Oficial("General");
//       expect(oficial_base.militares.length, 0);
//       Raso raso = Raso("Raso");
//       oficial_base.agregar(raso);
//       expect(oficial_base.militares.length, 1);
//     });

//     test("Prueba de jerarquia Simple", () {
//       Raso raso = Raso("Raso");
//       expect(raso.imprimirJerarquia(0),
//           "Raso\n"); // la jerarquía debería imprimir únicamente ese Militar
//     });

//     test("Prueba de getOficiales() para que no se añada el Raso Simple", () {
//       Oficial oficial = Oficial("Oficial");
//       Raso raso = Raso("Raso");
//       oficial.agregar(raso);
//       expect(oficial.getOficiales().length,
//           1); // getOficiales() solo devuelve la lista de oficiales, incluyendose a sí mismo, por tanto su tamaño será 1 y no 2 si se incluyera el raso
//     });

//     test('Agregar militar a un raso', () {
//       Raso raso = Raso("Raso1");
//       Oficial oficial = Oficial("Oficial1");

//       expect(raso.agregar(oficial),
//           false); // No se pueden agregar oficiales a un raso
//     });

//     late Raso raso1, raso2, raso3, raso4;
//     late Oficial oficial1, oficial2, oficial3, oficial4;

//     setUp(() {
//       raso1 = Raso("Raso1");
//       raso2 = Raso("Raso2");
//       raso3 = Raso("Raso3");
//       raso4 = Raso("Raso4");
//       oficial1 = Oficial("Oficial1");
//       oficial2 = Oficial("Oficial2");
//       oficial3 = Oficial("Oficial3");
//       oficial4 = Oficial("Oficial4");

//       oficial1.agregar(oficial2);
//       oficial1.agregar(oficial3);
//       oficial1.agregar(raso1);
//       oficial2.agregar(raso2);
//       oficial2.agregar(raso3);

//       oficial3.agregar(raso4);
//       oficial3.agregar(oficial4);
//     });

//     test("Prueba de jerarquia Compleja", () {
//       String salida = """
// Oficial1
// |      Oficial2
// |      |      Raso2
// |      |      Raso3
// |      Oficial3
// |      |      Raso4
// |      |      Oficial4
// |      Raso1
// """;

//       expect(oficial1.imprimirJerarquia(0), salida);
//     });

//     test("Prueba de getOficiales() para que no se añada el Raso Completa", () {
//       expect(oficial1.getOficiales().length, 4);
//     });

//     test("Prueba de getOficiales() para que se muestre en preorden", () {
//       List<Militar> oficiales = oficial1.getOficiales();
//       List<Militar> oficialesEsperados = [
//         oficial1,
//         oficial2,
//         oficial3,
//         oficial4
//       ];
//       expect(oficiales, oficialesEsperados);
//     });
//   });

//   /////////// TESTS DEL GRUPO DE CLASES DEL CONTROLADOR ///////////
//   group('GRUPO TESTS DEL CONTROLADOR', () {
//     // clase Gestor
//     test(
//         'Funcion ganador() devuelve uno de los dos equipos al terminar la partida',
//         () {
//       Gestor gestor = Gestor();

//       while (!gestor.partidaFinalizada()) {
//         gestor.equipo1ataca();
//         gestor.equipo2ataca();
//       }

//       expect(gestor.ganador(), anyOf(1, 2));
//     });

//     test('Funcion ganador() devuelve 0 durante la partida', () {
//       Gestor gestor = Gestor();
//       expect(gestor.ganador(), 0);
//     });

//     test('Comprobar aleatoriedad del equipo que inicia el ataque', () {
//       int empiezaE1 = 0;
//       int empiezaE2 = 0;
//       const int numSimulaciones = 1000;

//       for (int i = 0; i < numSimulaciones; i++) {
//         // hacemos 1000 batallas
//         final gestorBatalla = Gestor();
//         gestorBatalla.comenzarBatalla();
//         if (gestorBatalla.empiezaEq1) {
//           empiezaE1++;
//         } else {
//           empiezaE2++;
//         }
//       }

//       expect(
//           empiezaE1,
//           closeTo(500,
//               30)); // Si la probabilidad es la misma al hacer 1000 simulaciones cada equipo habrá empezado sobre 500 veces
//       expect(
//           empiezaE2,
//           closeTo(500,
//               30)); // le damos un margen de 30 arriba y abajo dado que puede variar un poco
//     });

//     test('Cambio de ataque por turno', () {
//       Gestor gestorBatalla = Gestor();
//       gestorBatalla.jefe1.agregar(Oficial("ofi1"));
//       gestorBatalla.jefe2.agregar(Oficial("Ofi2"));

//       bool todosigual = true;
//       bool cambiaataque = false;

//       int i = 0;
//       Ataque primero1 =
//           AtaqueMaritimo(); //Voy a poner esto por defecto para inicializarlo
//       Ataque primero2 = AtaqueMaritimo();
//       bool setprimero = false;
//       while (!gestorBatalla.partidaFinalizada()) {
//         if (i % 2 == 0) {
//           gestorBatalla.equipo1setAtaque();
//           gestorBatalla.equipo1ataca();

//           Ataque a = gestorBatalla.jefe1
//               .ataque; //Cogemos el ataque del jefe en este turno, para comprobar que el resto del ejercito tiene el mismo
//           if (!setprimero) {
//             primero1 = gestorBatalla.jefe1
//                 .ataque; //Cogemos el ataque que se le pone al ejercito en el primer turno, para comprobar que despues en otros se cambia.
//             setprimero = true;
//           }
//           if (a != primero1 && !cambiaataque)
//             cambiaataque =
//                 true; //Si mi ataque en este turno es distinto del que tuve en el primero, ya sabemos que cambia. Si ya ha cambiado no comprobamos más

//           for (Militar m in gestorBatalla.getOficiales1()) {
//             if (m.ataque != a && todosigual)
//               todosigual =
//                   false; //si el ataque no es el mismo que el del jefe, no se actualiza bien. Si ya se ha visto q no es igual en algun momento no comprobamos más
//           }
//         } else {
//           gestorBatalla.equipo2setAtaque();
//           gestorBatalla.equipo2ataca();

//           Ataque b = gestorBatalla.jefe2
//               .ataque; //Cogemos el ataque del jefe en este turno, para comprobar que el resto del ejercito tiene el mismo
//           if (!setprimero) {
//             primero2 = gestorBatalla.jefe2
//                 .ataque; //Cogemos el ataque que se le pone al ejercito en el primer turno, para comprobar que despues en otros se cambia.
//             setprimero = true;
//           }
//           if (b != primero2 && !cambiaataque)
//             cambiaataque =
//                 true; //Si mi ataque en este turno es distinto del que tuve en el primero, ya sabemos que cambia. Si ya ha cambiado no comprobamos más

//           for (Militar m in gestorBatalla.getOficiales2()) {
//             if (m.ataque != b && todosigual)
//               todosigual =
//                   false; //si el ataque no es el mismo que el del jefe, no se actualiza bien. Si ya se ha visto q no es igual en algun momento no comprobamos más
//           }
//         }
//         i++;
//       }
//       expect(todosigual, true);
//       expect(cambiaataque, true);
//     });

//     test("Cualquier militar recibe el daño de todos los del otro equipo", () {
//       Gestor gestorBatalla = Gestor();
//       gestorBatalla.jefe1.agregar(Oficial("ofi1"));
//       gestorBatalla.jefe2.agregar(Oficial("Ofi2"));

//       gestorBatalla
//           .equipo1setAtaque(); //Ponemos un ataque al equipo 1 y hacemos ataque al ejercito 2
//       gestorBatalla.equipo1ataca();

//       double danio = gestorBatalla.jefe1.ataque.danio;
//       bool correcto = true;

//       for (Militar m in gestorBatalla.getOficiales2()) {
//         if (m.vida - 150 - (danio * 2 * 0.8) > 0.0001 && correcto)
//           correcto = false;
//         //Comprueba si la vida que le queda es el daño que hace el ataque (x2 pq hay dos oficiales que atacan) en cada uno de los oficiales del otro
//         //El *0.8 es porque los oficiales reciben solo un 80% del ataque.
//         //En caso de que ya no sea correcto en cualquiera, ya no lo sigue comprobando
//         //Tengo el >0.0001 en lugar de igualarlos porque habia algún caso que comparaba 148.39999999999998 y 148.4, dando error.
//       }

//       expect(correcto, true);
//     });

//     test("CantidadVivos y terminar correctos", () {
//       Gestor gestorBatalla = Gestor();
//       gestorBatalla.jefe1.agregar(Oficial("ofi1"));
//       gestorBatalla.jefe2.agregar(Raso("raso1"));

//       expect(gestorBatalla.partidaFinalizada(), false);

//       //Por defecto tienen un AtaqueMaritimo que hace 2 de daño, 4 de daño entre los 2 al raso y 3.6 al oficial
//       //Para quitar 100 de vida al raso 2 habria que hacer 25 ataques del ejercito 1, para quitar los 150 de vida al jefe habría que hacer 47 ataques.
//       for (int i = 0; i < 24; i++) {
//         gestorBatalla.equipo1ataca();
//       }
//       gestorBatalla.equipo2vivos();
//       expect(gestorBatalla.e2vivos,
//           2); //Haciendo 49 ataques deben quedar los dos vivos y que no termina aun la partida
//       expect(gestorBatalla.partidaFinalizada(), false);

//       gestorBatalla.equipo1ataca();
//       gestorBatalla.equipo2vivos();
//       expect(gestorBatalla.e2vivos,
//           1); //Con el ataque 50 deberia marcar que queda 1 solo y que no termina aun la partida
//       expect(gestorBatalla.partidaFinalizada(), false);

//       for (int i = 25; i < 46; i++) {
//         gestorBatalla.equipo1ataca();
//       }
//       gestorBatalla.equipo2vivos();
//       expect(gestorBatalla.e2vivos,
//           1); //Haciendo 93 ataques debe quedar el jefe vivo y que no termina aun la partida
//       expect(gestorBatalla.partidaFinalizada(), false);

//       gestorBatalla.equipo1ataca();
//       gestorBatalla.equipo2vivos();
//       expect(gestorBatalla.e2vivos,
//           0); //Con el ataque 94 deberia marcar que no queda ninguno y que termina la partida
//       expect(gestorBatalla.partidaFinalizada(), true);
//       expect(gestorBatalla.ganador(), 1);
//     });

//     test('Comprobar qué se guardan datos en el registro', () {
//       Gestor gestor = Gestor();
//       gestor.equipo1vivos();
//       gestor.equipo2vivos();

//       gestor.equipo1ataca();
//       gestor.equipo2ataca();

//       final registro = gestor.registro;
//       expect(registro.contains("-----El equipo 1 ha hecho un"), true);
//       expect(registro.contains(">>>>>El equipo 2 ha hecho un"), true);
//     });
//   });

//   /////////// TESTS DEL GRUPO DE CLASES DE LA VISTA ///////////
//   group("GRUPO TESTS DE LA VISTA", () {
//     // clase RegistroBatalla
//     testWidgets('Interfaz de usuario', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: RegistroBatalla()));

//       // Comprobación de widgets de la interfaz
//       expect(find.text('Nombre del militar'), findsNWidgets(2));
//       expect(find.text('Superior Seleccionado'), findsNWidgets(2));
//       expect(find.text('Seleccionar oficial superior (1)'), findsOneWidget);
//       expect(find.text('Seleccionar oficial superior (2)'), findsOneWidget);
//       expect(find.text('Oficial'), findsNWidgets(2));
//       expect(find.text('Raso'), findsNWidgets(2));
//       expect(find.text('Mostrar jerarquía del Equipo 1'), findsOneWidget);
//       expect(find.text('Mostrar jerarquía del Equipo 2'), findsOneWidget);
//       expect(find.text(' COMENZAR BATALLA '), findsOneWidget);

//       // Simular la interacción del usuario: tocar el botón "Seleccionar oficial superior"
//       await tester.tap(find.text('Seleccionar oficial superior (1)').first,
//           warnIfMissed: false);
//       await tester.pump(); // Esperar a los cambios en la interfaz

//       // Simular la interacción del usuario: tocar el botón " COMENZAR BATALLA "
//       await tester.tap(find.text(' COMENZAR BATALLA '), warnIfMissed: false);
//       await tester.pump(); // Esperar a los cambios en la interfaz
//       expect(find.text('***** RESULTADO DE LA BATALLA *****'), findsOneWidget);
//     });
//   });
}
