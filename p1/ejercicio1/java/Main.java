
import java.util.Random;

public class Main {
    public static void main(String[] args) {

        //CREACION DE LAS FACTORIAS 
        FactoriaCarreraYBicicleta factoriaMontana = new FactoriaMontana();
        FactoriaCarreraYBicicleta factoriaCarretera = new FactoriaCarretera();

        //FABRICACION DE LAS CARRERAS
        Carrera carreraMontana = factoriaMontana.crearCarrera("Carrera de las bicis de montaña");
        Carrera carreraCarretera = factoriaCarretera.crearCarrera("Carrera de las bicis de carretera");
        
        //SELECCION DEL NUMERO DE PARTICIPANTES 
        Random num_random_bicis = new Random();
        int num_bicis = num_random_bicis.nextInt(21) + 10;

        //FABRICACION DE LAS BICICLETAS
        carreraMontana.aniadirBicicletas(factoriaMontana.crearBicicletas(num_bicis)); 
        carreraCarretera.aniadirBicicletas(factoriaCarretera.crearBicicletas(num_bicis));

        //REALIZACION DE LAS CARRERAS
    
        final Object lock = new Object(); // Para impedir la escritura concurrente por pantalla

        //usamos dos hebras, cada una encargada de un tipo de carrera
        Thread hebra1 = new Thread(() -> {
            
            synchronized (lock){ 
                carreraMontana.inicio(); // dado que estas funciones tienen salida por panatalla debemos impedir el acceso simultaneo por parte de ambas hebras
            }

            for (int i = 0; i < 6; i++) {
                System.out.println(Thread.currentThread().getName() + " : " + carreraMontana.nombre + " -- " + (float) i/6 + " % ");
                try {
                    Thread.sleep(1000); //dormimos las hebras un segundo en 6 ocasiones para simular la duracion de la carrera
                } catch (InterruptedException e) {
                    System.out.println("La hebra fue interrumpida");
                }
            }

            synchronized (lock){
                System.out.println("\n");
                carreraMontana.fin();
            }

        });

        Thread hebra2 = new Thread(() -> {
            
            synchronized (lock){

                carreraCarretera.inicio();
            }

            for (int i = 0; i < 6; i++) {
                System.out.println(Thread.currentThread().getName() + " : " + carreraCarretera.nombre + " -- " + (float) i/6 + " % ");
                try {
                    Thread.sleep(1000); 
                } catch (InterruptedException e) {
                    System.out.println("La hebra fue interrumpida");
                }
            }

            synchronized (lock){
                System.out.println("\n");
                carreraCarretera.fin();
            }

        });

        hebra1.start();
        hebra2.start();


    }
}
