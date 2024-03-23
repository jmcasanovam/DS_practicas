from abc import ABC, abstractmethod


class Ataque(ABC):
    desgaste = 0
    @abstractmethod
    def atacar(self):
        pass

    @abstractmethod
    def danio(self):
        pass

class AtaqueAereo(Ataque):
    desgaste = 10
    
    def atacar(self):
        print("Ataque aereo")

    def danio(self):
        return self.desgaste
        

class AtaqueTerrestre(Ataque):
    desgaste = 5
    
    def atacar(self):
        print("Ataque aereo")

    def danio(self):
        return self.desgaste
        

class AtaqueMaritimo(Ataque):
    desgaste = 20
    
    def atacar(self):
        print("Ataque aereo")

    def danio(self):
        return self.desgaste