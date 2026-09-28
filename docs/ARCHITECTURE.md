# Arquitectura NETQIRA

## Capas
- presentation: pantallas, widgets, animaciones y estados visuales.
- domain: entidades y casos de uso.
- data: repositorios, base local, APIs y plataforma.
- core: navegación, tema, red, permisos, errores y componentes compartidos.

## Features V1
- onboarding
- home
- speed_test
- results
- history
- network_info
- servers
- profile
- settings

## Principios
- Sin valores simulados en producción.
- UI desacoplada del motor de medición.
- Historial local offline-first.
- Permisos solicitados solo cuando una función los necesita.
- Android nativo solo donde Flutter no exponga datos suficientes.
