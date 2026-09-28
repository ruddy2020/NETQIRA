# NETQIRA

Aplicación Android para medir y comprender la calidad real de una conexión de Internet.

## Arquitectura
- Flutter / Android
- Riverpod para estado
- go_router para navegación
- Drift + SQLite para historial local
- Capa nativa Kotlin para información avanzada de red
- Motor de medición desacoplado de la UI
- Servidores de prueba configurables

## Flujo FIGENO
1. Cambios pequeños por fase.
2. Cada cambio llega como parche Unified Diff.
3. Antes de aplicar: git apply --check.
4. Después: format + analyze + test.
5. Commit por fase estable.
