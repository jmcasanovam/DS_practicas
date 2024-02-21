import java.util.ArrayList;

public interface Carrera {
    void inicio();

    void aniadirBicicleta(Bicicleta bicicleta);

    void quitarBicicleta(Bicicleta bicicleta);

    ArrayList<Bicicleta> getBicicletas();
}
