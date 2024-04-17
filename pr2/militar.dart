import 'dart:math';
import 'ataque.dart';

/* abstract class Ataque {
  int danio();
  void atacar();
}

class ArmaBlanca extends Ataque {
  @override
  int danio() {
    return Random().nextInt(20) + 10; // Genera un valor aleatorio entre 10 y 29
  }

  @override
  void atacar() {
    print("Atacando con arma blanca!");
  }
}

class ArmaFuego extends Ataque {
  @override
  int danio() {
    return Random().nextInt(30) + 20; // Genera un valor aleatorio entre 20 y 49
  }

  @override
  void atacar() {
    print("Disparando arma de fuego!");
  }
} */

abstract class Militar {
  String nombre;
  String rango;
  double resistencia, vida;
  Ataque ataque;

  Militar(this.nombre, this.rango, this.vida, this.resistencia, this.ataque);

  void atacar(Militar m) {

    resistencia -= ataque.atacar(m);
    
    /* print("Yo, $nombre voy a atacar.");

    if (resistencia > ataque.danio()) {
      resistencia -= ataque.danio();
      realizarAtaque();
      print("Me queda $resistencia resistencia.");
    } else {
      print("No tengo resistencia suficiente para atacar");
    } */


  }


  void recibeAtaque(double danio);

  void setAtaque(Ataque ataque) {
    this.ataque = ataque;
  }

  void agregar(Militar militar);

  void quitar(Militar militar);

  
  void totexto(){
    print("vida:$vida resistencia: $resistencia \n");
  }
}

class Raso extends Militar {
  Raso(String nombre, String rango, Ataque ataque)
      : super(nombre, rango, 100.0, 100.0, ataque);


  @override
  void agregar(Militar militar) {
    print("No se pueden agregar militares a un raso");
  }

  @override
  void quitar(Militar militar) {
    print("No se pueden quitar militares a un raso");
  }

  @override
  void recibeAtaque(double danio){
    vida = vida - danio;
  }
}

class Oficial extends Militar {
  List<Militar> militares = [];

  Oficial(String nombre, String rango, Ataque ataque)
      : super(nombre, rango, 150, 150, ataque);

  @override
  void atacar(Militar m){
    for(Militar militar in militares){
      militar.resistencia -= militar.ataque.atacar(m);
    }
    resistencia -= ataque.atacar(m);
  }

  @override
  void agregar(Militar militar) {
    militares.add(militar);
  }

  @override
  void quitar(Militar militar) {
    militares.remove(militar);
  }

    @override
  void recibeAtaque(double danio){
    vida = vida - danio*0.8;
    for( Militar m in militares){
      m.recibeAtaque(danio);
    }
  }
}

void main() {
  var raso = Raso("Soldado1", "Raso", AtaqueAereo());
  var raso2 = Raso("Soldado2", "Raso", AtaqueAereo());
  var oficial = Oficial("Oficial1", "Comandante", AtaqueMaritimo());
  var oficial2 = Oficial("Oficial2", "Comandante", AtaqueMaritimo());

  oficial.agregar(raso);
  oficial2.agregar(raso2);
  oficial2.atacar(oficial);
  oficial.totexto();
  raso.totexto();
  oficial2.totexto();
  raso2.totexto();

}
