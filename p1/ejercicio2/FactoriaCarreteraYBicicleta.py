from abc import ABC, abstractmethod
from Carrera import CarreraCarretera, CarreraMontana
from Bicicleta import BicicletaCarretera, BicicletaMontana
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
    
