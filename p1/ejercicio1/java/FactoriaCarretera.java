import java.util.ArrayList;

public class FactoriaCarretera implements FactoriaCarreraYBicicleta{

    @Override
    public ArrayList<Bicicleta> crearBicicletas(int num) {
        ArrayList<Bicicleta> vectorBicicletaCarretera = new ArrayList<>();
        for(int i=0 ; i<num ; i++)
            vectorBicicletaCarretera.add(new BicicletaCarretera(i));
        return vectorBicicletaCarretera;

    }

    @Override
    public Carrera crearCarrera(String nom) {
        return new CarreraCarretera(nom);
    }
    
}
