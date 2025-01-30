# DS_practicas
Repositorio para trabajar en equipo en la asignatura de Desarrollo de Software.

## Descripción
Este proyecto es un pequeño videojuego local para dos jugadores donde cada participante crea su propio ejército jerárquico y simula una batalla entre ellos. El sistema selecciona de forma aleatoria el tipo de ataque para añadir heterogeneidad y dinamismo al enfrentamiento.

Al finalizar la simulación, el juego muestra el ejército ganador junto con un registro detallado de cada acción realizada durante la batalla.

La aplicación fue diseñada para explorar y aplicar patrones de arquitectura de software, como Strategy y Composite, permitiendo un diseño modular, flexible y extensible.

## Características Principales
- Creación de Ejércitos: Los jugadores pueden construir sus ejércitos jerárquicos con diferentes tipos de soldados organizados en estructuras compuestas.
- Simulación de Batalla: Los combates se ejecutan automáticamente, seleccionando los ataques de manera aleatoria para ofrecer diversidad en las estrategias.
- Registro Completo: Visualización de todas las acciones que ocurrieron durante la batalla y el resultado final.
- Interfaz de Usuario: Widgets interactivos para crear ejércitos, iniciar batallas, visualizar jerarquías y revisar informes detallados.

## Patrones de Diseño Aplicados
- Composite: Para representar la jerarquía de soldados y permitir la agrupación de diferentes unidades bajo una estructura común.
- Strategy: Para implementar diferentes tipos de ataques de los soldados, seleccionados dinámicamente durante la simulación.
