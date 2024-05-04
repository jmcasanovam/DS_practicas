// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:militares/main.dart';
import 'package:militares/militar.dart';

void main() {
  // test("Prueba de ataque", () {
  //   Raso raso = Raso("Raso");
  //   Raso raso2 = Raso("Raso2");
  //   raso.atacar(raso2);
  //   expect(raso2.vida, 98);
  // });

  // test("Prueba de cantidad de vivos", () {
  //   Oficial oficial = Oficial("Oficial");
  //   Oficial oficial2 = Oficial("Oficial2");
  //   Raso raso = Raso("Raso");
  //   oficial.agregar(oficial2);
  //   oficial.agregar(raso);
  //   expect(oficial.cantidadVivos(), 2);
  // });

  // test("Prueba de cantidad de vivos con baja", () {
  //   Oficial oficial = Oficial("Oficial");
  //   Oficial oficial2 = Oficial("Oficial2");
  //   Raso raso = Raso("Raso");
  //   oficial.agregar(oficial2);
  //   oficial.agregar(raso);
  //   oficial2.vida = 0;
  //   expect(oficial.cantidadVivos(), 1);
  // });

  group("Jerarquía Militar", () {
    late Raso raso1, raso2, raso3, raso4;
    late Oficial oficial1, oficial2, oficial3, oficial4;

    setUp(() {
      raso1 = Raso("Raso1");
      raso2 = Raso("Raso2");
      raso3 = Raso("Raso3");
      raso4 = Raso("Raso4");
      oficial1 = Oficial("Oficial1");
      oficial2 = Oficial("Oficial2");
      oficial3 = Oficial("Oficial3");
      oficial4 = Oficial("Oficial4");

      oficial1.agregar(oficial2);
      oficial1.agregar(oficial3);
      oficial1.agregar(raso1);
      oficial2.agregar(raso2);
      oficial2.agregar(raso3);

      oficial3.agregar(raso4);
      oficial3.agregar(oficial4);

    });
    test("Prueba de jerarquia Simple", () {
      Raso raso = Raso("Raso");
      expect(raso.imprimirJerarquia(0), "Raso\n");
    });

    test("Prueba de jerarquia Compleja", () {
      String salida = """
Oficial1
|      Oficial2
|      |      Raso2
|      |      Raso3
|      Oficial3
|      |      Raso4
|      |      Oficial4
|      Raso1
""";

      expect(oficial1.imprimirJerarquia(0), salida);
    });

    test("Prueba de getOficiales para que no se añada el Raso Simple", () {
      Oficial oficial = Oficial("Oficial");
      Raso raso = Raso("Raso");
      oficial.agregar(raso);
      expect(oficial.getOficiales().length, 1);
    });

    test("Prueba de getOficiales para que no se añada el Raso Completa", () {
      expect(oficial1.getOficiales().length, 4);
    });

    test("Prueba de getOficiales para que se muestre en preorden", () {
      List<Militar> oficiales = oficial1.getOficiales();
      List<Militar> oficialesEsperados = [oficial1, oficial2, oficial3, oficial4];
      expect(oficiales, oficialesEsperados);
    });
  });
}
