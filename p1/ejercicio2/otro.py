from abc import ABC, abstractmethod
import random
import time
import copy


#Definición de las Factorias
class FactoriaCarreteraYBicicleta(ABC):
    @abstractmethod
    def crear_carrera(self):
        pass

    @abstractmethod
    def crear_bicicleta(self, num):
        pass

class FactoriaCarretera(FactoriaCarreteraYBicicleta):
    def crear_carrera(self, nombre):
        return CarreraCarretera(nombre)

    def crear_bicicleta(self, num):
        return [BicicletaMontana(i) for i in range(num)]
    
class FactoriaMontana(FactoriaCarreteraYBicicleta):
    def crear_carrera(self, nombre):
        return CarreraMontana(nombre)

    def crear_bicicleta(self, num):
        return [BicicletaCarretera(i) for i in range(num)]
    

class Prototype:
    @abstractmethod
    def clone(self):
        pass

#Definición de las Bicicletas
class Bicicleta(ABC):
    def __init__(self, id=0):
        self.id = id

    def clone(self):
        return copy.deepcopy(self)

class BicicletaCarretera(Bicicleta):
    def __init__(self, id):
        super().__init__(id)

    def clone(self):
        return copy.deepcopy(self)

class BicicletaMontana(Bicicleta):
    def __init__(self, id):
        super().__init__(id)

    def clone(self):
        return copy.deepcopy(self)

#Definición de las Carreras
class Carrera():
    def __init__(self, nombre):
        self.nombre = nombre
        self.bicicletas = []

    def inicio(self):
        print("INICIO DE", self.nombre)
        print("***************\n")
        self.listar_participantes()
        total_bicis_a_retirar =self.get_bicicletas_retiradas()
        # for i in range(total_bicis_a_retirar):
        #     self.bicicletas.pop(random.Random.randint(0, len(self.bicicletas) - 1))  # Eliminamos una bicicleta del total
        indices_bicis_a_retirar = random.sample(range(len(self.bicicletas)), total_bicis_a_retirar)
        for index in sorted(indices_bicis_a_retirar, reverse=True):
            del self.bicicletas[index]
        print("***************\n")


    def fin(self):
        print("FIN DE", self.nombre)
        self.listar_participantes()
        print("***************\n")

    def aniadir_bicicletas(self, bicicletas):
        for bicicleta in bicicletas:
            self.bicicletas.append(bicicleta)

    def get_bicicletas_retiradas(self):
        pass


    def listar_participantes(self):
        print(self.nombre, "--- Hay", len(self.bicicletas), "participantes:")
        for bicicleta in self.bicicletas:
            print("Bici ", bicicleta.id)


class CarreraCarretera(Carrera):  
    def __init__(self, nombre):
        super().__init__(nombre)

    def get_bicicletas_retiradas(self):
        return int(len(self.bicicletas) * 0.1)

class CarreraMontana(Carrera):
    def __init__(self, nombre):
        super().__init__(nombre)

    def get_bicicletas_retiradas(self):
        return int(len(self.bicicletas) * 0.2)  
    

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

    

