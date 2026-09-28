# NETQIRA — Motor de medición Fase 3

## Objetivo
Esta fase conecta la interfaz de Speed Test con mediciones reales de red.

## Orden
1. Selección automática entre varios puntos de prueba compatibles con LibreSpeed.
2. Ping HTTP.
3. Jitter calculado desde las muestras de ping.
4. Descarga real contando bytes recibidos y tiempo transcurrido.
5. Subida real contando bytes enviados y tiempo transcurrido.
6. Resultado mostrado en vivo en la interfaz.

## Importante
- El ping implementado aquí es latencia HTTP contra el servidor de prueba, no ICMP.
- Los nodos iniciales proceden de la lista pública de servidores de LibreSpeed.
- Esta Fase 3 usa una prueba rápida para desarrollo: aproximadamente 12 MiB de descarga y 6 MiB de subida.
- En una fase posterior se implementará duración adaptativa, lista remota de servidores, cancelación y selección geográfica.
- NETQIRA no inventa valores: si el servidor falla, la interfaz muestra error y permite reintentar.