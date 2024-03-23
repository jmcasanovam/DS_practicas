import random
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
    
