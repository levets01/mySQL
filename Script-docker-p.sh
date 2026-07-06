#!/bin/bash
# Script automático que detecta y libera puertos ocupados
# No necesita parámetros, hace todo solo

echo "🔍 Escaneando puertos ocupados..."

# Función para liberar un puerto
liberar_puerto() {
    local port=$1
    local proceso=$2
    
    echo "⚠️  Puerto $port está ocupado por: $proceso"
    
    # Obtener el PID
    local pid=$(sudo lsof -t -i:$port 2>/dev/null)
    if [ -z "$pid" ]; then
        pid=$(sudo netstat -tulpn 2>/dev/null | grep ":$port" | awk '{print $7}' | cut -d'/' -f1)
    fi
    
    if [ ! -z "$pid" ]; then
        echo "🔪 Cerrando proceso PID: $pid"
        sudo kill -9 $pid 2>/dev/null
        sleep 1
        echo "✅ Puerto $port liberado"
        return 0
    fi
    return 1
}

# DETECTAR PUERTOS OCUPADOS

# 1. Detectar puertos de Docker
echo ""
echo "🐳 Verificando contenedores Docker..."
docker ps --format "table {{.Ports}}" 2>/dev/null | grep -E "[0-9]+->" | while read line; do
    port=$(echo $line | grep -oP '[0-9]+(?=->)' | head -1)
    if [ ! -z "$port" ]; then
        liberar_puerto $port "Docker"
    fi
done

# 2. Detectar puertos comunes ocupados
echo ""
echo "🔌 Verificando puertos comunes..."
PUERTOS_COMUNES="80 443 8080 3000 5000 8000 3306 5432 6379 27017"

for port in $PUERTOS_COMUNES; do
    # Verificar si el puerto está ocupado
    if sudo lsof -i:$port &>/dev/null || sudo netstat -tulpn 2>/dev/null | grep -q ":$port"; then
        # Obtener nombre del proceso
        proceso=$(sudo lsof -i:$port 2>/dev/null | grep LISTEN | awk '{print $1}' | head -1)
        if [ -z "$proceso" ]; then
            proceso=$(sudo netstat -tulpn 2>/dev/null | grep ":$port" | awk '{print $7}' | cut -d'/' -f2)
        fi
        
        # Si el proceso no es sistema (no tocar puertos del sistema)
        if [[ ! "$proceso" =~ ^(systemd|sshd|cron|dbus|network) ]]; then
            liberar_puerto $port "$proceso"
        fi
    fi
done

# 3. Detectar TODOS los puertos en uso por procesos no esenciales
echo ""
echo "🔎 Buscando otros procesos que puedan interferir..."

# Buscar procesos de Node, Python, Java, etc
PROCESOS_PELIGROSOS="node python java ruby php nginx apache mysql postgres redis mongod"
for proc in $PROCESOS_PELIGROSOS; do
    pids=$(pgrep -f $proc 2>/dev/null)
    if [ ! -z "$pids" ]; then
        for pid in $pids; do
            # Obtener el puerto que usa este proceso
            port=$(sudo lsof -p $pid -a -iTCP -sTCP:LISTEN 2>/dev/null | grep LISTEN | awk '{print $9}' | cut -d':' -f2)
            if [ ! -z "$port" ]; then
                echo "⚠️  Proceso $proc (PID: $pid) usando puerto $port"
                liberar_puerto $port "$proc"
            fi
        done
    fi
done

echo ""
echo "✅ Limpieza automática completada"
