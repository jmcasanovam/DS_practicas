import java.util.ArrayList;
import java.util.Random;

public abstract class Carrera {
    ArrayList<Bicicleta> bicicletas;
    String nombre;

    public Carrera(String s){
        bicicletas = new ArrayList<>();
        nombre = s;
    }

    public void inicio(){
        System.out.println("INICIO DE "+nombre);
        listarParticipantes();

        int total_bicis_a_retirar = getBicicletasRetiradas(); // Segun el tipo se retiran mas o menos
        
        Random indice_bici_a_eliminar = new Random();

        for(int i=0; i < total_bicis_a_retirar; i++){
            bicicletas.remove(indice_bici_a_eliminar.nextInt(bicicletas.size())); //del total de bicis, eliminamos una
        }
        System.out.println("***************\n");
        
    }

    public void fin(){
        System.out.println("FIN DE "+nombre);
        listarParticipantes();
        System.out.println("***************\n");
    }

    void aniadirBicicletas(ArrayList<Bicicleta> bicicletas){
        for (int i=0; i < bicicletas.size(); i++){
            this.bicicletas.add(bicicletas.get(i));
        }
    }

    abstract int getBicicletasRetiradas();

    private void listarParticipantes(){
        System.out.println(nombre+" --- Hay " + bicicletas.size()+ " participantes:");

        for (int i=0; i < bicicletas.size(); i++){
            System.out.println("Bici "+bicicletas.get(i).id);
        }
    }
}
