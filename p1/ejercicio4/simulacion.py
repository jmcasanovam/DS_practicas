from gestor_filtros import GestorFiltros
from filtro import FiltroRepercutirRozamiento, FiltroCalcularVelocidad

class SimulacionVehiculo:
    def __init__(self):
        self.gestor_filtros = GestorFiltros()
        self.gestor_filtros.agregar_filtro(FiltroRepercutirRozamiento())
        self.gestor_filtros.agregar_filtro(FiltroCalcularVelocidad())

    def simular(self, salpicadero):
        revoluciones = self.gestor_filtros.ejecutar(salpicadero)
        salpicadero.ejecutar(revoluciones, salpicadero.estado)
