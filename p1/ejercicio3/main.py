# Creación de un ejercito militar. Usaremos el patrón Composite para crear el ejercito, donde distinguimos entre raso y oficial. De esta forma, un oficial puede tener otro militar a su cargo, pero un raso no puede tener a nadie a su cargo.
#También usaremos el patron de Estrategia para distinguir entre diferentes tipos de ataque.

from abc import ABC, abstractmethod

class Militar(ABC):
    def __init__(self, nombre, rango, vida, ataque):
        self.nombre = nombre
        self.rango = rango
        self.vida = vida
        self.ataque = ataque

    @abstractmethod
    def atacar(self):
        pass

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


    def atacar(self):
        print(f"Yo, {self.nombre} voy a atacar.")

        if(self.vida > self.ataque.atacar()):
            self.vida -= self.ataque.atacar()
            print(f"Me queda {self.vida}  vida.")
        else:
            print(f"No tengo vida suficiente para atacar")

    def set_ataque(self,ataque):
        self.ataque = ataque

    def agregar(self, militar):
        print("No se pueden agregar militares a un raso")

    def quitar(self, militar):
        print("No se pueden quitar militares a un raso")

    def mostrar(self):
        print(f"Nombre: {self.nombre}, Rango: {self.rango}, Vida: {self.vida}")

class Oficial(Militar):
    def __init__(self, nombre, rango, ataque):
        super().__init__(nombre, rango, 200, ataque)
        self.militares = []

    def atacar(self):
        print(f"Yo, {self.nombre} voy a atacar.")
        
        if(self.vida > self.ataque.atacar()):
            self.vida -= self.ataque.atacar()
            print(f"Me queda {self.vida}  vida.")
        else:
            print(f"No tengo vida suficiente para atacar")

    def set_ataque(self,ataque):
        self.ataque = ataque

    def agregar(self, militar):
        self.militares.append(militar)

    def quitar(self, militar):
        self.militares.remove(militar)

    def mostrar(self):
        print(f"Nombre: {self.nombre}, Rango: {self.rango}, Vida: {self.vida}")
        for militar in self.militares:
            militar.mostrar()

class Ataque(ABC):
    @abstractmethod
    def atacar(self):
        pass

class AtaqueAereo(Ataque):
    def atacar(self):
        print("Ataque aereo")
        return 10

class AtaqueTerrestre(Ataque):
    def atacar(self):
        print("Ataque terrestre")
        return 5

class AtaqueMaritimo(Ataque):
    def atacar(self):
        print("Ataque maritimo")
        return 20


def main():
    
    raso1 = Raso("Raso 1", "Raso", AtaqueMaritimo())
    raso2 = Raso("Raso 2", "Raso", AtaqueMaritimo())
    oficial1 = Oficial("Juan", "Coronel", AtaqueAereo())
    oficial2 = Oficial("Jose", "Coronel", AtaqueAereo())

    oficial1.agregar(oficial2)
    oficial2.agregar(raso1)
    oficial2.agregar(raso2)
    oficial1.mostrar() #Se muestra la jerarquía

    print(f"Ingrese una tecla: \n-M para ataque maritimo \n-A para ataque aereo \n-T para ataque terrestre \n-Q para terminar ")

    while True:
        tecla = input("Ingrese una tecla: ")
        
        if tecla.lower() == "m":
            oficial1.set_ataque(AtaqueMaritimo())
            oficial1.atacar()
        elif tecla.lower() == "a":
            oficial1.set_ataque(AtaqueAereo())
            oficial1.atacar()
        elif tecla.lower() == "t":
            oficial1.set_ataque(AtaqueTerrestre())
            oficial1.atacar()
        elif tecla.lower() == "q":
            break
        else:
            print("Tecla no válida. Intente nuevamente.")

    

if __name__ == "__main__":
    main()

