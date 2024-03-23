from abc import ABC, abstractmethod
import copy

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