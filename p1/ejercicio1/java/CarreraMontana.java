public class CarreraMontana extends Carrera{
    CarreraMontana(String nom){
        super(nom);
    }

    @Override
    int getBicicletasRetiradas(){
        return (int) (bicicletas.size() * 0.2);
    }
    
}
