import 'ataque.dart';

abstract class Militar {
  String nombre;
  bool oficial;
  double vida;
  Ataque ataque;
  String? usuario;

  Militar(this.nombre, this.oficial, this.vida, this.ataque, {this.usuario});

  String atacar(Militar m) {
    ataque.atacar(m);
    String danioLog = "Militar $nombre realiza: ${ataque.danio}\n";
    return danioLog;
  }

  void recibeAtaque(double danio);

  void setAtaque(Ataque ataque) {
    this.ataque = ataque;
  }

  bool agregar(Militar militar);

  void eliminarHijos();

  int cantidadVivos();

  String imprimirJerarquia(int indent);

  List<Militar> getOficiales();

  List<Militar> getRasos();

  factory Militar.fromJson(Map<String, dynamic> json){
    if(json['oficial']){
      return Oficial(
        json['nombre'] as String,
        usuario: json['usuario'],
      );
    }else{
      return Oficial(
        json['nombre'] as String,
        usuario: json['usuario'],
      );
    }
  }

  Map<String, dynamic> toJson(String padre){
    return {
      'nombre': nombre,
      'oficial': oficial,
      'usuario': usuario,
      'nombre_superior': padre
    };
  }
}

class Raso extends Militar {
  Raso(String nombre, {String? usuario})
      : super(nombre, false, 100.0, AtaqueMaritimo());

  @override
  bool agregar(Militar militar) {
    // print("No se pueden agregar militares a un raso");
    return false;
  }

  @override
  void eliminarHijos() {
    
  }

  @override
  void recibeAtaque(double danio) {
    vida = vida - danio;
  }

  @override
  String imprimirJerarquia(int indent) {
    String salida = "${sumarIndentacion(indent)}$nombre\n";
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

  @override
  List<Militar> getRasos() {
    return [this];
  }

  
}

class Oficial extends Militar {
  List<Militar> militares = [];

  Oficial(String nombre, {String? usuario})
      : super(nombre, true, 150, AtaqueMaritimo());

  @override
  String atacar(Militar m) {
    for (Militar militar in militares) {
      militar.atacar(m);
    }
    ataque.atacar(m);
    return "";
  }

  @override
  bool agregar(Militar militar) {
    militares.add(militar);
    return true;
  }

  @override
  void eliminarHijos() {
    for(int i=0; i<militares.length; i++){
      militares[i].eliminarHijos();
      militares.removeAt(i);
    }
    // for(Militar m in militares){
    //   m.eliminarHijos();
    //   militares.remove(m);
    // }
  }

  @override
  void setAtaque(Ataque ataque) {
    this.ataque=ataque;
    for (Militar m in militares) {
      m.setAtaque(ataque);
    }
  }

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
    txt += "${sumarIndentacion(indent)}$nombre\n";
    for (int i = 0; i < militares.length; i++) {
      txt += militares[i].imprimirJerarquia(indent + 1);
    }
    return txt;
  }

  @override
  int cantidadVivos() {
    int vivos=0;
    if(vida>0) vivos+=1;//por mi mismo
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

  @override
  List<Militar> getRasos(){
    List<Militar> rasos = [];
    if(militares.isEmpty){
      return rasos;
    }else{
      for(Militar m in militares){
        rasos.addAll(m.getRasos());
      }
    }
    return rasos;
  }
}

String sumarIndentacion(int indent) {
  String indentacion = "";
  for (int i = 0; i < indent; i++) {
    indentacion += "|      ";
  }
  return indentacion;
}
