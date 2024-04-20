import 'ataque.dart';
import 'dart:io';

abstract class Militar {
  String nombre;
  bool oficial;
  double vida;
  Ataque ataque;

  Militar(this.nombre, this.oficial, this.vida, this.ataque);

  String atacar(Militar m) {
    ataque.atacar(m);
    String danioLog = "Militar $nombre realiza: ${ataque.danio}\n";
    return danioLog;
  }

  void recibeAtaque(double danio);

  void setAtaque(Ataque ataque) {
    this.ataque = ataque;
  }

  void agregar(Militar militar);

  int cantidadVivos();

  //void quitar(Militar militar);

  String imprimirJerarquia(int indent);

  void totexto() {
    print("vida:$vida  \n");
  }

  List<Militar> getOficiales();
}

class Raso extends Militar {
  Raso(String nombre, bool oficial, Ataque ataque)
      : super(nombre, oficial, 100.0, ataque);

  @override
  void agregar(Militar militar) {
    print("No se pueden agregar militares a un raso");
  }

  //@override
  //void quitar(Militar militar) {
  //  print("No se pueden quitar militares a un raso");
  //}

  @override
  void recibeAtaque(double danio) {
    vida = vida - danio;
  }

  @override
  String imprimirJerarquia(int indent) {
    String salida = sumarIndentacion(indent) + nombre + "\n";
    return salida;
  }

  @override
  int cantidadVivos() {
    if(vida>0){
      return 1;
    }
    return 0;
  }

  @override
  List<Militar> getOficiales() {
    return [];
  }
}

class Oficial extends Militar {
  List<Militar> militares = [];

  Oficial(String nombre, bool oficial, Ataque ataque)
      : super(nombre, oficial, 150, ataque);

  @override
  String atacar(Militar m) {
    for (Militar militar in militares) {
      militar.atacar(m);
    }
    ataque.atacar(m);
    String danioLog = "Militar $nombre realiza: ${ataque.danio}\n";
    return danioLog;
  }

  @override
  void agregar(Militar militar) {
    militares.add(militar);
  }

  @override
  void setAtaque(Ataque ataque) {
    for (Militar m in militares) {
      m.setAtaque(ataque);
    }
  }

  //@override
  //void quitar(Militar militar) {
  //  militares.remove(militar);
  //}

  @override
  void recibeAtaque(double danio) {
    vida = vida - danio * 0.8;
    for (Militar m in militares) {
      m.recibeAtaque(danio);
    }
  }

  @override
  String imprimirJerarquia(int indent) {
    String txt = "";
    txt += "${sumarIndentacion(indent)} $nombre\n";
    for (int i = 0; i < militares.length; i++) {
      txt += militares[i].imprimirJerarquia(indent + 1);
    }
    return txt;
  }

  @override
  int cantidadVivos() {
    int vivos = 1;//por mi mismo
    for (Militar m in militares) {
      vivos += m.cantidadVivos();
    }
    return vivos;
  }
  
  @override
  List<Militar> getOficiales(){
    List<Militar> oficiales = [this];
    if(militares.isEmpty){
      return oficiales;
    }else{
      for(Militar m in militares){
        oficiales.addAll(m.getOficiales());
      }
    }
    return oficiales;
  }
}

String sumarIndentacion(int indent) {
  String indentacion = "";
  for (int i = 0; i < indent; i++) {
    indentacion += "   ";
  }
  return indentacion;
}
