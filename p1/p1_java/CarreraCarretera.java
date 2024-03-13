public class CarreraCarretera extends Carrera{
    CarreraCarretera(String nom){
        super(nom);
    }

    @Override
    int getBicicletasRetiradas(){
        return (int) (bicicletas.size() * 0.1);
    }
}
