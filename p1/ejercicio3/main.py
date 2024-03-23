# Creación de un ejercito militar. Usaremos el patrón Composite para crear el ejercito, donde distinguimos entre raso y oficial. De esta forma, un oficial puede tener otro militar a su cargo, pero un raso no puede tener a nadie a su cargo.
#También usaremos el patron de Estrategia para distinguir entre diferentes tipos de ataque.

from militar import Militar, Raso, Oficial
from ataque import AtaqueAereo, AtaqueMaritimo, AtaqueTerrestre

def main():
    
    raso1 = Raso("Raso 1", "Raso", AtaqueMaritimo())
    raso2 = Raso("Raso 2", "Raso", AtaqueMaritimo())
    oficial1 = Oficial("Juan", "Coronel", AtaqueAereo())
    oficial2 = Oficial("Jose", "Coronel", AtaqueAereo())

    oficial1.agregar(oficial2)
    oficial2.agregar(raso1)
    oficial2.agregar(raso2)
    oficial1.mostrar() #Se muestra la jerarquía

    print(f"Ingrese una tecla: \n-M para ataque maritimo \n-A para ataque aereo \n-T para ataque terrestre \n-Q para terminar ")

    while True:
        tecla = input("Ingrese una tecla: ")
        
        if tecla.lower() == "m":
            oficial1.set_ataque(AtaqueMaritimo())
            oficial1.atacar()
        elif tecla.lower() == "a":
            oficial1.set_ataque(AtaqueAereo())
            oficial1.atacar()
        elif tecla.lower() == "t":
            oficial1.set_ataque(AtaqueTerrestre())
            oficial1.atacar()
        elif tecla.lower() == "q":
            break
        else:
            print("Tecla no válida. Intente nuevamente.")

    

if __name__ == "__main__":
    main()

