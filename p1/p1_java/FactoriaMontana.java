import java.util.ArrayList;

public class FactoriaMontana implements FactoriaCarreraYBicicleta{

    @Override
    public  ArrayList<Bicicleta> crearBicicletas(int n) {
        ArrayList<Bicicleta> vectorBicicletasMontana= new ArrayList<>();
        for(int i=0; i<n; i++)
        {
            vectorBicicletasMontana.add(new BicicletaMontana(i));
        }
        return vectorBicicletasMontana;
    }

    @Override
    public Carrera crearCarrera(String s) {
        return new CarreraMontana(s);
    }
    
}
