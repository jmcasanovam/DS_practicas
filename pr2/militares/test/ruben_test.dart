// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:militares/main.dart';
import 'package:militares/gestor.dart';
import 'package:militares/militar.dart';
import 'package:militares/ataque.dart';

void main() {

  
 


  test('Cambio de ataque por turno', () {
    Gestor gestorBatalla = Gestor();
    gestorBatalla.jefe1.agregar(Oficial("ofi1"));
    gestorBatalla.jefe2.agregar(Oficial("Ofi2"));

    bool todosigual = true;
    bool cambiaataque = false;
    
    int i = 0;
    Ataque primero1 = AtaqueMaritimo(); //Voy a poner esto por defecto para inicializarlo
    Ataque primero2 = AtaqueMaritimo();
    bool setprimero=false;
    while (!gestorBatalla.partidaFinalizada()) {
      if (i % 2 == 0) {
        gestorBatalla.equipo1setAtaque();
        gestorBatalla.equipo1ataca();

        Ataque a = gestorBatalla.jefe1.ataque;  //Cogemos el ataque del jefe en este turno, para comprobar que el resto del ejercito tiene el mismo
        if(!setprimero){
          primero1=gestorBatalla.jefe1.ataque;   //Cogemos el ataque que se le pone al ejercito en el primer turno, para comprobar que despues en otros se cambia.
          setprimero=true;
        }
        if(a!=primero1 && !cambiaataque) cambiaataque=true;    //Si mi ataque en este turno es distinto del que tuve en el primero, ya sabemos que cambia. Si ya ha cambiado no comprobamos más

        for(Militar m in gestorBatalla.getOficiales1()){
          if(m.ataque!=a && todosigual) todosigual=false;     //si el ataque no es el mismo que el del jefe, no se actualiza bien. Si ya se ha visto q no es igual en algun momento no comprobamos más
        }
      } else {
        gestorBatalla.equipo2setAtaque();
        gestorBatalla.equipo2ataca();

        Ataque b = gestorBatalla.jefe2.ataque;  //Cogemos el ataque del jefe en este turno, para comprobar que el resto del ejercito tiene el mismo
        if(!setprimero){
          primero2=gestorBatalla.jefe2.ataque;   //Cogemos el ataque que se le pone al ejercito en el primer turno, para comprobar que despues en otros se cambia.
          setprimero=true;
        }
        if(b!=primero2 && !cambiaataque) cambiaataque=true;    //Si mi ataque en este turno es distinto del que tuve en el primero, ya sabemos que cambia. Si ya ha cambiado no comprobamos más

        for(Militar m in gestorBatalla.getOficiales2()){
          if(m.ataque!=b && todosigual) todosigual=false;     //si el ataque no es el mismo que el del jefe, no se actualiza bien. Si ya se ha visto q no es igual en algun momento no comprobamos más
        }
      }
      i++;
    }
    expect(todosigual, true);
    expect(cambiaataque, true);
  });

  test("Cualquier militar recibe el daño de todos los del otro equipo", () {
    Gestor gestorBatalla = Gestor();
    gestorBatalla.jefe1.agregar(Oficial("ofi1"));
    gestorBatalla.jefe2.agregar(Oficial("Ofi2"));

    gestorBatalla.equipo1setAtaque();     //Ponemos un ataque al equipo 1 y hacemos ataque al ejercito 2
    gestorBatalla.equipo1ataca();

    double danio=gestorBatalla.jefe1.ataque.danio;
    bool correcto=true;

    for(Militar m in gestorBatalla.getOficiales2()){
      if(m.vida-150-(danio*2*0.8)>0.0001 && correcto) correcto=false;
      //Comprueba si la vida que le queda es el daño que hace el ataque (x2 pq hay dos oficiales que atacan) en cada uno de los oficiales del otro
      //El *0.8 es porque los oficiales reciben solo un 80% del ataque.
      //En caso de que ya no sea correcto en cualquiera, ya no lo sigue comprobando
      //Tengo el >0.0001 en lugar de igualarlos porque habia algún caso que comparaba 148.39999999999998 y 148.4, dando error.
    }

    expect(correcto, true);

  });

  test("CantidadVivos y terminar correctos", () {
    Gestor gestorBatalla = Gestor();
    gestorBatalla.jefe1.agregar(Oficial("ofi1"));
    gestorBatalla.jefe2.agregar(Raso("raso1"));

    expect(gestorBatalla.partidaFinalizada(), false);

    //Por defecto tienen un AtaqueMaritimo que hace 2 de daño, 4 de daño entre los 2 al raso y 3.6 al oficial
    //Para quitar 100 de vida al raso 2 habria que hacer 25 ataques del ejercito 1, para quitar los 150 de vida al jefe habría que hacer 47 ataques.
    for(int i=0; i<24; i++) {
      gestorBatalla.equipo1ataca();
    }
    gestorBatalla.equipo2vivos();
    expect(gestorBatalla.e2vivos, 2); //Haciendo 49 ataques deben quedar los dos vivos y que no termina aun la partida
    expect(gestorBatalla.partidaFinalizada(), false);

    gestorBatalla.equipo1ataca();
    gestorBatalla.equipo2vivos();
    expect(gestorBatalla.e2vivos, 1); //Con el ataque 50 deberia marcar que queda 1 solo y que no termina aun la partida
    expect(gestorBatalla.partidaFinalizada(), false);

    for(int i=25; i<46; i++){
      gestorBatalla.equipo1ataca();
    }
    gestorBatalla.equipo2vivos();
    expect(gestorBatalla.e2vivos, 1); //Haciendo 93 ataques debe quedar el jefe vivo y que no termina aun la partida
    expect(gestorBatalla.partidaFinalizada(), false);

    gestorBatalla.equipo1ataca();
    gestorBatalla.equipo2vivos();
    expect(gestorBatalla.e2vivos, 0); //Con el ataque 94 deberia marcar que no queda ninguno y que termina la partida
    expect(gestorBatalla.partidaFinalizada(), true);
    expect(gestorBatalla.ganador(), 1);

  });

}
