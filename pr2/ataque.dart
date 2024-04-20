import "militar.dart";

abstract class Ataque{
  double danio = 0;


  void atacar(Militar m){
    m.recibeAtaque(danio);
  }
}

class AtaqueAereo extends Ataque{
  AtaqueAereo(){
    danio=5;
  }
}

class AtaqueTerrrestre extends Ataque{
  AtaqueTerrrestre(){
    danio=1;
  }
}

class AtaqueMaritimo extends Ataque{
  AtaqueMaritimo(){
    danio=2;
  }
}
