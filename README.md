
Script Automático de Liberación de Puertos

Descripción General

Este script en Bash está diseñado para automatizar completamente la liberación de puertos en sistemas Ubuntu/Linux. Detecta automáticamente qué puertos están ocupados, identifica los procesos que los están usando, y los cierra para dejar los puertos libres.

¿Para qué sirve?

· Resolver conflictos de puertos al levantar contenedores Docker
· Liberar puertos bloqueados por procesos caídos o mal cerrados
· Automatizar la limpieza antes de desplegar aplicaciones
· Evitar errores del tipo address already in use

✨ Características Principales

· ✅ Detección automática de puertos ocupados
· ✅ Identificación de procesos (Docker, Node, Python, Java, etc.)
· ✅ Liberación segura (no toca procesos del sistema)
· ✅ Múltiples métodos de detección (lsof, netstat, pgrep)
· ✅ No requiere parámetros - ejecutar y olvidar
· ✅ Feedback visual con emojis y colores

---

📦 Instalación

Método 1: Instalación Rápida

```bash
# 1. Crear el archivo del script
nano script-docker-p.sh

# 2. Copiar y pegar el código del script

# 3. Dar permisos de ejecución
chmod +x script-docker-p.sh

# 5. ¡Listo! Ahora puedes ejecutarlo desde cualquier lugar

sudo bash script-docker-p.sh

```
