from abc import ABC, abstractmethod
from estado_motor import EstadoMotor
    
class Filtro(ABC):
    @abstractmethod
    def ejecutar(self, revoluciones, estado_motor):
        pass 

class FiltroRepercutirRozamiento(Filtro):
    VALOR_ROZAMIENTO = 4

    def ejecutar(self, revoluciones, estado_motor):
        return max(0, revoluciones -  FiltroRepercutirRozamiento.VALOR_ROZAMIENTO)  # Reducción constante de RPM debido al rozamiento

class FiltroCalcularVelocidad(Filtro):
    def ejecutar(self, revoluciones, estado_motor):
        incremento_velocidad = 0
        if estado_motor == EstadoMotor.APAGADO or estado_motor == EstadoMotor.ENCENDIDO:
            incremento_velocidad = 0
        elif estado_motor == EstadoMotor.ACELERANDO:
            incremento_velocidad = 100
        elif estado_motor == EstadoMotor.FRENANDO:
            incremento_velocidad = -100
        
        rpm_actualizadas = max(0, min(revoluciones + incremento_velocidad, 5000))
        return rpm_actualizadas
