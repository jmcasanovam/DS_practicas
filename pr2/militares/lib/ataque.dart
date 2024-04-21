import "militar.dart";

abstract class Ataque{
  double danio = 0;


  void atacar(Militar m){
    m.recibeAtaque(danio);
  }

  String totxt();
}

class AtaqueAereo extends Ataque{
  AtaqueAereo(){
    danio=5;
  }
  
  @override
  String totxt(){
    return "Ataque Aereo";
  }
}

@override
class AtaqueTerrrestre extends Ataque{
  AtaqueTerrrestre(){
    danio=1;
  }

  @override
  String totxt(){
    return "Ataque Terrestre";
  }
}

class AtaqueMaritimo extends Ataque{
  AtaqueMaritimo(){
    danio=2;
  }

  @override
  String totxt(){
    return "Ataque Maritimo";
  }
  
}
