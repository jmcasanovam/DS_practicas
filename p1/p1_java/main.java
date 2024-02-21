import java.util.ArrayList;
import java.util.Random;

// Interfaz para la factoría abstracta
interface FactoryRaceAndBike {
    Race createRace();
    Bike createBike();
}

// Clase abstracta para representar una bicicleta
abstract class Bike {
    protected int id;
    
    public Bike(int id) {
        this.id = id;
    }
    
    public int getId() {
        return id;
    }
}

// Clase abstracta para representar una carrera
abstract class Race {
    protected ArrayList<Bike> bikes;
    
    public Race() {
        bikes = new ArrayList<>();
    }
    
    public abstract void start();
    
    public void addBike(Bike bike) {
        bikes.add(bike);
    }
    
    public void removeBike(Bike bike) {
        bikes.remove(bike);
    }
    
    public ArrayList<Bike> getBikes() {
        return bikes;
    }
}

// Implementación de una bicicleta de montaña
class MountainBike extends Bike {
    public MountainBike(int id) {
        super(id);
    }
}

// Implementación de una bicicleta de carretera
class RoadBike extends Bike {
    public RoadBike(int id) {
        super(id);
    }
}

// Implementación de una carrera de montaña
class MountainRace extends Race {
    @Override
    public void start() {
        System.out.println("La carrera de montaña ha comenzado!");
    }
}

// Implementación de una carrera de carretera
class RoadRace extends Race {
    @Override
    public void start() {
        System.out.println("La carrera de carretera ha comenzado!");
    }
}

// Factoría específica para bicicletas y carreras de montaña
class MountainFactory implements FactoryRaceAndBike {
    @
