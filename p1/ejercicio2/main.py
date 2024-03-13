import random
import time

class Bicicleta:
    def __init__(self, n=0):
        self.id = n

class BicicletaCarretera(Bicicleta):
    def __init__(self, n=0):
        super().__init__(n)

class BicicletaMontana(Bicicleta):
    def __init__(self, n=0):
        super().__init__(n)

class Carrera:
    def __init__(self, s):
        self.bicicletas = []
        self.nombre = s

    def inicio(self):
        print("INICIO DE", self.nombre)
        self.listar_participantes()

        total_bicis_a_retirar = self.get_bicicletas_retiradas()
        indices_bicis_a_eliminar = random.sample(range(len(self.bicicletas)), total_bicis_a_retirar)

        for index in sorted(indices_bicis_a_eliminar, reverse=True):
            del self.bicicletas[index]

        print("***************\n")

    def fin(self):
        print("FIN DE", self.nombre)
        self.listar_participantes()
        print("***************\n")

    def aniadir_bicicletas(self, bicicletas):
        self.bicicletas.extend(bicicletas)

    def get_bicicletas_retiradas(self):
        pass

    def listar_participantes(self):
        print(self.nombre, "--- Hay", len(self.bicicletas), "participantes:")
        for bicicleta in self.bicicletas:
            print("Bici", bicicleta.id)

class CarreraCarretera(Carrera):
    def __init__(self, nom):
        super().__init__(nom)

    def get_bicicletas_retiradas(self):
        return int(len(self.bicicletas) * 0.1)

class CarreraMontana(Carrera):
    def __init__(self, nom):
        super().__init__(nom)

    def get_bicicletas_retiradas(self):
        return int(len(self.bicicletas) * 0.2)

class FactoriaCarreraYBicicleta:
    def crear_carrera(self, s):
        pass

    def crear_bicicletas(self, n):
        pass

class FactoriaCarretera(FactoriaCarreraYBicicleta):
    def crear_bicicletas(self, num):
        return [BicicletaCarretera(i) for i in range(num)]

    def crear_carrera(self, nom):
        return CarreraCarretera(nom)

class FactoriaMontana(FactoriaCarreraYBicicleta):
    def crear_bicicletas(self, n):
        return [BicicletaMontana(i) for i in range(n)]

    def crear_carrera(self, s):
        return CarreraMontana(s)

def main():
    # CREACION DE LAS FACTORIAS
    factoria_montana = FactoriaMontana()
    factoria_carretera = FactoriaCarretera()

    # FABRICACION DE LAS CARRERAS
    carrera_montana = factoria_montana.crear_carrera("Carrera de las bicis de montaña")
    carrera_carretera = factoria_carretera.crear_carrera("Carrera de las bicis de carretera")

    # SELECCION DEL NUMERO DE PARTICIPANTES
    num_bicis = random.randint(10, 30)

    # FABRICACION DE LAS BICICLETAS
    carrera_montana.aniadir_bicicletas(factoria_montana.crear_bicicletas(num_bicis))
    carrera_carretera.aniadir_bicicletas(factoria_carretera.crear_bicicletas(num_bicis))

    # REALIZACION DE LAS CARRERAS
    carrera_montana.inicio()
    for i in range(6):
        print("Carrera de montaña --", i / 6, "%")
        print()
        time.sleep(1)  # Simulación de duración de la carrera
    carrera_montana.fin()

    carrera_carretera.inicio()
    for i in range(6):
        print("Carrera de carretera --", i / 6, "%")
        print()
        time.sleep(1)  # Simulación de duración de la carrera
    carrera_carretera.fin()

if __name__ == "__main__":
    main()
