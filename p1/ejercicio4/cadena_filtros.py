# Cadena de filtros
class CadenaFiltros:
    def __init__(self):
        self.filtros = []

    def ejecutar_filtros(self, salpicadero):
        revoluciones = salpicadero.rpm
        for filtro in self.filtros:
            revoluciones = filtro.ejecutar(revoluciones, salpicadero.estado)
        return revoluciones
