import tkinter as tk
from estado_motor import EstadoMotor

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
        self.boton_encendido = tk.Button(marco1, text="Encender", fg="green", command=self.btn_encendido, width=10, height=1)
        self.boton_encendido.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio 
        tk.Label(marco1, width=1).pack(side="left", expand=True)

        # Botón para acelerar
        self.boton_acelerar = tk.Button(marco1, text="Acelerar", command=self.btn_acelerar, width=15, height=1)
        self.boton_acelerar.pack(side="left", padx=5, pady=5)
        # widget de relleno para distribuir el espacio
        tk.Label(marco1, width=1).pack(side="left", expand=True)

        # Botón para frenar
        self.boton_frenar = tk.Button(marco1, text="Frenar", command=self.btn_frenar, width=10, height=1)
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

    def btn_encendido(self):
        self.estado_motor(0)

    def btn_acelerar(self):
        self.estado_motor(1)

    def btn_frenar(self):
        self.estado_motor(2)

    def estado_motor(self, n):
        if n == 0:
            if self.salpicadero.estado == EstadoMotor.ENCENDIDO or self.salpicadero.estado == EstadoMotor.ACELERANDO or self.salpicadero.estado == EstadoMotor.FRENANDO:
                self.panelPrincipal.config(text="APAGADO")
                self.boton_encendido.config(text="Encender", fg="green")
                self.boton_acelerar.config(text="Acelerar", fg="black")
                self.boton_frenar.config(text="Frenar", fg="black")
                self.salpicadero.estado = EstadoMotor.APAGADO
            elif self.salpicadero.estado == EstadoMotor.APAGADO:
                self.boton_encendido.config(text="Apagar", fg="red")
                self.panelPrincipal.config(text="ENCENDIDO")  
                self.salpicadero.estado = EstadoMotor.ENCENDIDO
        elif n == 1:
            if self.salpicadero.estado == EstadoMotor.ACELERANDO:
                self.panelPrincipal.config(text="ENCENDIDO")
                self.boton_acelerar.config(text="Acelerar", fg="black")
                self.salpicadero.estado = EstadoMotor.ENCENDIDO
            elif self.salpicadero.estado == EstadoMotor.ENCENDIDO:
                self.panelPrincipal.config(text="ACELERANDO")
                self.boton_acelerar.config(text="Soltar acelerador", fg="red")
                self.salpicadero.estado = EstadoMotor.ACELERANDO
        elif n == 2:
            if self.salpicadero.estado == EstadoMotor.FRENANDO:
                self.panelPrincipal.config(text="ENCENDIDO")
                self.boton_frenar.config(text="frenar", fg="black")
                self.salpicadero.estado = EstadoMotor.ENCENDIDO
            elif self.salpicadero.estado == EstadoMotor.ENCENDIDO:
                self.panelPrincipal.config(text="FRENANDO")
                self.boton_frenar.config(text="Soltar freno", fg="red")
                self.salpicadero.estado = EstadoMotor.FRENANDO

    def actualizar_estado(self):
        self.simulacion.simular(self.salpicadero)
        self.kilometroshora.config(text=self.salpicadero.velocidad_lineal)
        self.cuentakilometros.config(text=self.salpicadero.distancia_recorrida)
        self.cuentakilometrosRec.config(text=self.salpicadero.distancia_recorrida_rec)
        self.revoluciones.config(text=self.salpicadero.rpm)
        self.ventana.after(1000, self.actualizar_estado)

    def ejecutar(self):
        self.ventana.after(1000, self.actualizar_estado)
        self.ventana.mainloop()
