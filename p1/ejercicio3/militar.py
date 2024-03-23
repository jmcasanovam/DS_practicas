from abc import ABC, abstractmethod

class Militar(ABC):
    def __init__(self, nombre, rango, resistencia, ataque):
        self.nombre = nombre
        self.rango = rango
        self.resistencia = resistencia
        self.ataque = ataque

    def atacar(self):
        print(f"Yo, {self.nombre} voy a atacar.")

        if(self.resistencia > self.ataque.danio()):
            self.resistencia -= self.ataque.danio()
            self.ataque.atacar()
            print(f"Me queda {self.resistencia}  resistencia.")
        else:
            print(f"No tengo resistencia suficiente para atacar")

    @abstractmethod
    def set_ataque(ataque):
        pass

    @abstractmethod
    def agregar(self, militar):
        pass

    @abstractmethod
    def quitar(self, militar):
        pass

    @abstractmethod
    def mostrar(self):
        pass

class Raso(Militar):
    def __init__(self, nombre, rango, ataque):
        super().__init__(nombre, rango, 100, ataque)

    def set_ataque(self,ataque):
        self.ataque = ataque

    def agregar(self, militar):
        print("No se pueden agregar militares a un raso")

    def quitar(self, militar):
        print("No se pueden quitar militares a un raso")

    def mostrar(self):
        print(f"Nombre: {self.nombre}, Rango: {self.rango}, Resistencia: {self.resistencia}")

class Oficial(Militar):
    def __init__(self, nombre, rango, ataque):
        super().__init__(nombre, rango, 200, ataque)
        self.militares = []

    def set_ataque(self,ataque):
        self.ataque = ataque

    def agregar(self, militar):
        self.militares.append(militar)

    def quitar(self, militar):
        self.militares.remove(militar)

    def mostrar(self):
        print(f"Nombre: {self.nombre}, Rango: {self.rango}, Resistencia: {self.resistencia}")
        for militar in self.militares:
            militar.mostrar()


