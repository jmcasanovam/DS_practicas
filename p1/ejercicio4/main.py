import tkinter as tk
from abc import ABC, abstractmethod
from math import pi

# Enum para el estado del motor
class EstadoMotor:
    APAGADO = 0
    ACELERANDO = 1
    FRENANDO = 2
    ENCENDIDO = 3

# Definimos una función para cada botón
def btn_encendido():
    estadoMotor(0)

def btn_acelerar():
    estadoMotor(1)

def btn_frenar():
    estadoMotor(2)

# PARA DEFINIR EL ESTADO DEL MOTOR 
def estadoMotor(n): 
    if n == 0:
        if salpicadero.estado == EstadoMotor.ENCENDIDO or salpicadero.estado == EstadoMotor.ACELERANDO or salpicadero.estado == EstadoMotor.FRENANDO:
            interfaz.panelPrincipal.config(text="APAGADO")
            interfaz.boton_encendido.config(text="Encender", fg="green")
            interfaz.boton_acelerar.config(text="Acelerar", fg="black")
            interfaz.boton_frenar.config(text="Frenar", fg="black")
            salpicadero.estado = EstadoMotor.APAGADO
        elif salpicadero.estado == EstadoMotor.APAGADO:
            interfaz.boton_encendido.config(text="Apagar", fg="red")
            interfaz.panelPrincipal.config(text="ENCENDIDO")  
            salpicadero.estado = EstadoMotor.ENCENDIDO
    elif n == 1:
        if salpicadero.estado == EstadoMotor.ACELERANDO:
            interfaz.panelPrincipal.config(text="ENCENDIDO")
            interfaz.boton_acelerar.config(text="Acelerar", fg="black")
            salpicadero.estado = EstadoMotor.ENCENDIDO
        elif salpicadero.estado == EstadoMotor.ENCENDIDO:
            interfaz.panelPrincipal.config(text="ACELERANDO")
            interfaz.boton_acelerar.config(text="Soltar acelerador", fg="red")
            salpicadero.estado = EstadoMotor.ACELERANDO
    elif n == 2:
        if salpicadero.estado == EstadoMotor.FRENANDO:
            interfaz.panelPrincipal.config(text="ENCENDIDO")
            interfaz.boton_frenar.config(text="frenar", fg="black")
            salpicadero.estado = EstadoMotor.ENCENDIDO
        elif salpicadero.estado == EstadoMotor.ENCENDIDO:
            interfaz.panelPrincipal.config(text="FRENANDO")
            interfaz.boton_frenar.config(text="Soltar freno", fg="red")
            salpicadero.estado = EstadoMotor.FRENANDO

######################################################################

# Clase filtro
class Filtro(ABC):
    @abstractmethod
    def ejecutar(self, revoluciones, estado_motor):
        pass 

class CadenaFiltros:
    def __init__(self):
        self.filtros = []
    
    def ejecutar_filtros(self, salpicadero):
        revoluciones = salpicadero.rpm
        for filtro in self.filtros:
            revoluciones = filtro.ejecutar(revoluciones, salpicadero.estado)
        return revoluciones

# Gestor de filtros
class GestorFiltros:
    def __init__(self):
        self.cadena_filtros = CadenaFiltros()

    def agregar_filtro(self, filtro):
        self.cadena_filtros.filtros.append(filtro)

    def ejecutar(self, salpicadero):
        return self.cadena_filtros.ejecutar_filtros(salpicadero)
    
# Subclase de Filtro para calcular la velocidad
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

# Subclase de Filtro para calcular el efecto del rozamiento
class FiltroRepercutirRozamiento(Filtro):
    def ejecutar(self, revoluciones, estado_motor):
        return max(0, revoluciones - 4)  # Reducción constante de RPM debido al rozamiento

######################################################################

# Clase salpicadero (Objetivo)
class Salpicadero:
    def __init__(self): #Inicialmente a 0 (motor apagado)
        self.velocidad_lineal = 0
        self.distancia_recorrida = 0
        self.distancia_recorrida_rec = 0
        self.rpm = 0
        self.estado = EstadoMotor.APAGADO

    def ejecutar(self, revoluciones, estado_motor):
        if(estado_motor != EstadoMotor.APAGADO): 
            self.rpm = revoluciones
            self.velocidad_lineal = self.calcular_velocidad_lineal(revoluciones) # Calcula la velocidad
            self.distancia_recorrida += self.velocidad_lineal / 3600  # Calcula la distancia en funcion de vel
            self.distancia_recorrida_rec += self.velocidad_lineal / 3600 # Calcula la distancia en funcion de vel
            self.distancia_recorrida = round(self.distancia_recorrida, 3)  # Redondeo a 3 decimales
            self.distancia_recorrida_rec = round(self.distancia_recorrida_rec, 3)  # Redondeo a 3 decimales        
        else: 
            self.distancia_recorrida_rec = 0
            self.rpm = 0
            self.velocidad_lineal = 0


    def calcular_velocidad_lineal(self, revoluciones): 
        radio = 0.15 
        velocidad_lineal = 2 * pi * radio * revoluciones * (60 / 1000)
        return round(velocidad_lineal,2)
    
######################################################################

# Aplicación principal (Cliente)
class SimulacionVehiculo:
    def __init__(self):
        self.gestor_filtros = GestorFiltros()
        self.gestor_filtros.agregar_filtro(FiltroRepercutirRozamiento())
        self.gestor_filtros.agregar_filtro(FiltroCalcularVelocidad())


    def simular(self, salpicadero):
        revoluciones = self.gestor_filtros.ejecutar(salpicadero) 
        salpicadero.ejecutar(revoluciones, salpicadero.estado)

######################################################################

# Interfaz gráfica 
class InterfazGrafica:
    def __init__(self, simulacion, salpicadero):
        self.salpicadero = salpicadero
        self.simulacion = simulacion

        self.ventana = tk.Tk()
        self.ventana.title("Simulación del movimiento de un vehículo con cambio automático")
        self.ventana.minsize(width=500, height=330)  

        self.panelPrincipal = tk.Label(self.ventana, text="APAGADO", fg="red", bg="lightgray", width=20, height=3, font=("Arial", 12, "bold"))
        self.panelPrincipal.pack(pady=15)

        # MARCO PARA LOS MANDOS #
        marco1 = tk.Frame(self.ventana, bd=2, relief="groove")
        marco1.pack(side="top", fill="both", expand=True, padx=10, pady=10)
        nombre_mandos = tk.Label(marco1, text="Mandos", font=("Arial", 12, "bold"))
        nombre_mandos.pack(pady=5)     
        # widget de relleno al inicio
        tk.Label(marco1).pack(side="left", expand=True)
        # Botón para encender el motor
        self.boton_encendido = tk.Button(marco1, text="Encender", fg="green", command=btn_encendido, width=10, height=1)
        self.boton_encendido.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio 
        tk.Label(marco1, width=1).pack(side="left", expand=True)
        # Botón para acelerar
        self.boton_acelerar = tk.Button(marco1, text="Acelerar", command=btn_acelerar, width=15, height=1)
        self.boton_acelerar.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio
        tk.Label(marco1, width=1).pack(side="left", expand=True)
        # Botón para frenar
        self.boton_frenar = tk.Button(marco1, text="Frenar", command=btn_frenar, width=10, height=1)
        self.boton_frenar.pack(side="left", padx=5, pady=5)
        # widget de relleno al final
        tk.Label(marco1).pack(side="left", expand=True)

        # MARCO PARA EL SALPICADERO #
        marco2 = tk.Frame(self.ventana, bd=2, relief="groove")
        marco2.pack(side="bottom", fill="both", expand=True, padx=10, pady=10)
        nombre_salpicadero = tk.Label(marco2, text="Salpicadero", font=("Arial", 12, "bold"))
        nombre_salpicadero.pack(pady=5)
        # widget de relleno al inicio
        tk.Label(marco2).pack(side="left", expand=True)
        # KILOMETROSHORA
        km = tk.Label(marco2, text="Km/h: ")
        km.pack(side="left", padx=5, pady=5)
        self.kilometroshora = tk.Label(marco2, text=0, width=5, height=3)
        self.kilometroshora.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio 
        tk.Label(marco2, width=1).pack(side="left", expand=True)
        # CUENTAKILOMETROS TOTAL
        cuenta = tk.Label(marco2, text="CtaKm total: ")
        cuenta.pack(side="left", padx=5, pady=5)
        self.cuentakilometros = tk.Label(marco2, text=0, width=6, height=3)
        self.cuentakilometros.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio 
        tk.Label(marco2, width=1).pack(side="left", expand=True)
        # CUENTAKILOMETROS RECIENTE
        cuentaRec = tk.Label(marco2, text="CtaKm reciente: ")
        cuentaRec.pack(side="left", padx=5, pady=5)
        self.cuentakilometrosRec = tk.Label(marco2, text=0.0, width=6, height=3)
        self.cuentakilometrosRec.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio
        tk.Label(marco2, width=1).pack(side="left", expand=True)
        # RPM
        rev = tk.Label(marco2, text="RPM: ")
        rev.pack(side="left", padx=5, pady=5)
        self.revoluciones = tk.Label(marco2, text=0, width=5, height=3)
        self.revoluciones.pack(side="left", padx=5, pady=5)
        # widget de relleno al final
        tk.Label(marco2).pack(side="left", expand=True)

    def actualizar_estado(self):
        self.simulacion.simular(self.salpicadero)
        self.kilometroshora.config(text = self.salpicadero.velocidad_lineal)
        self.cuentakilometros.config(text = self.salpicadero.distancia_recorrida)
        self.cuentakilometrosRec.config(text = self.salpicadero.distancia_recorrida_rec)
        self.revoluciones.config(text = self.salpicadero.rpm)
        self.ventana.after(1000,self.actualizar_estado)

    def ejecutar(self):
        self.ventana.after(1000,self.actualizar_estado)
        self.ventana.mainloop()


# Crear y ejecutar la simulación
simulacion = SimulacionVehiculo()
salpicadero = Salpicadero()
interfaz = InterfazGrafica(simulacion, salpicadero)
interfaz.ejecutar()