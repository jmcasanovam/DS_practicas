from math import pi
from estado_motor import EstadoMotor

class Salpicadero:
    def __init__(self):
        self.velocidad_lineal = 0
        self.distancia_recorrida = 0
        self.distancia_recorrida_rec = 0
        self.rpm = 0
        self.estado = EstadoMotor.APAGADO

    def ejecutar(self, revoluciones, estado_motor):
        if estado_motor != EstadoMotor.APAGADO:
            self.rpm = revoluciones
            self.velocidad_lineal = self.calcular_velocidad_lineal(revoluciones)
            self.distancia_recorrida += self.velocidad_lineal / 3600
            self.distancia_recorrida_rec += self.velocidad_lineal / 3600
            self.distancia_recorrida = round(self.distancia_recorrida, 3)
            self.distancia_recorrida_rec = round(self.distancia_recorrida_rec, 3)
        else:
            self.distancia_recorrida_rec = 0
            self.rpm = 0
            self.velocidad_lineal = 0

    def calcular_velocidad_lineal(self, revoluciones):
        radio = 0.15
        velocidad_lineal = 2 * pi * radio * revoluciones * (60 / 1000)
        return round(velocidad_lineal, 2)
