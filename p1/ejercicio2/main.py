import random
import time
from FactoriaCarreteraYBicicleta import FactoriaCarretera, FactoriaMontana


#Definición del Main
def main():
    #Creamos las factorias
    factoriaCarretera = FactoriaCarretera()
    factoriaMontana = FactoriaMontana()

    #Fabricación de las carreras
    carreraCarretera = factoriaCarretera.crear_carrera("Carrera de las bicis de carretera")
    carreraMontana = factoriaMontana.crear_carrera("Carrera de las bicis de montaña")

    #Selección del número de participantes
    numParticipantes = random.randint(10, 20)

    #Fabricación de las bicicletas
    carreraMontana.aniadir_bicicletas(factoriaMontana.crear_bicicleta(numParticipantes))
    carreraCarretera.aniadir_bicicletas(factoriaCarretera.crear_bicicleta(numParticipantes))

    #Realización de las carreras
    carreraMontana.inicio()

    for i in range(6):
        print("Carrera de montaña en progreso...", i/6, "%")
        time.sleep(1)

    carreraMontana.fin()

    carreraCarretera.inicio()

    for i in range(6):
        print("Carrera de carretera en progreso...", i/6, "%")
        time.sleep(1)

    carreraCarretera.fin()

if __name__ == "__main__":
    main()

    

