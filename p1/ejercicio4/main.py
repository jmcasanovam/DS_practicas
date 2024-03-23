import tkinter as tk
from salpicadero import Salpicadero
from simulacion import SimulacionVehiculo
from interfaz import InterfazGrafica

if __name__ == "__main__":
  # Crear y ejecutar la simulación
  simulacion = SimulacionVehiculo()
  salpicadero = Salpicadero()
  interfaz = InterfazGrafica(simulacion, salpicadero)
  interfaz.ejecutar()