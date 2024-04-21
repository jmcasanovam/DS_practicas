import 'dart:math';

import 'militar.dart';
import 'ataque.dart';

class Gestor {
  late Oficial jefe1;
  late Oficial jefe2;
  int e1vivos = -1;
  int e2vivos = -1;
  String registro = ""; //Lo que se muestra cuando se acaba la partida (log)
  bool fin = false;

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
    registro +="El equipo 1 ha atacado al equipo 2\n\tQuedan $e2vivos miembros del equipo 2 vivos";
  }

  void equipo2ataca() {
    registro += jefe2.atacar(jefe1);
    equipo1vivos();
    registro +="El equipo 2 ha atacado al equipo 1\n\tQuedan $e1vivos miembros del equipo 1 vivos";
  }

  Ataque devolverAtaqueRandom() {
    int r = Random().nextInt(3);
    Ataque ata = AtaqueMaritimo();

    switch (r) {
      case 1:
        ata = AtaqueAereo();
      case 2:
        ata = AtaqueTerrrestre();
      default:
        ata = AtaqueMaritimo();
    }
    return ata;
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
    if(fin){
      if(e1vivos == 0){
        return 2;
      }else{
        return 1;
      }
    }else{
      return 0;
    }
  }

  String getRegistro() {
    return registro;
  }

  // void aniadirJefe1(Militar m) {
  //   jefe1.agregar(m);
  // }

  // void aniadirJefe2(Militar m) {
  //   jefe2.agregar(m);
  // }

  List<Militar> getOficiales1(){
    return jefe1.getOficiales(); 
  }

  List<Militar> getOficiales2(){
    return jefe2.getOficiales(); 
  }

  Oficial getJefe1(){
    return jefe1;
  }

  Oficial getJefe2(){
    return jefe2;
  }

}
