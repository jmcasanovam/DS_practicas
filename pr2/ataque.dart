import "militar.dart";

abstract class Ataque{
  double danio = 0;
  double desgaste = 0;

  Ataque();
  double atacar(Militar m){
    m.recibeAtaque(danio);
    return desgaste;
  }
}

class AtaqueAereo extends Ataque{
  AtaqueAereo(){
    danio=5;
    desgaste=10;
  }
}

class AtaqueTerrrestre extends Ataque{
  AtaqueTerrrestre(){
    danio=1;
    desgaste=8;
  }
}

class AtaqueMaritimo extends Ataque{
  AtaqueMaritimo(){
    danio=2;
    desgaste=20;
  }

}
