from cadena_filtros import CadenaFiltros

# Gestor de filtros
class GestorFiltros:
    def __init__(self):
        self.cadena_filtros = CadenaFiltros()

    def agregar_filtro(self, filtro):
        self.cadena_filtros.filtros.append(filtro)

    def ejecutar(self, salpicadero):
        return self.cadena_filtros.ejecutar_filtros(salpicadero)
