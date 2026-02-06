#!/bin/bash
echo "🚀 Iniciando ejecución de pruebas en Jenkins..."

# 1. Intentar crear el venv, pero no morir si falla
python3 -m venv venv || echo "⚠️ No se pudo crear el venv, se usará el Python del sistema."

# 2. Intentar activar el venv
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    PYTHON_BIN="python3"
else
    echo "⚠️ venv no disponible. Instalando dependencias en el sistema..."
    PYTHON_BIN="python3"
fi

# 3. Instalar dependencias (usando --break-system-packages para entornos Debian nuevos)
$PYTHON_BIN -m pip install --upgrade pip
$PYTHON_BIN -m pip install pytest pytest-html -r requirements.txt --break-system-packages || $PYTHON_BIN -m pip install pytest pytest-html -r requirements.txt

# 4. CREAR LA CARPETA DE REPORTES (Aquí está el truco)
# Como entraste a 'proyecto_pytest', los reportes deben estar un nivel arriba
# para que Jenkins los encuentre en la raíz del workspace.
mkdir -p ../reports

# 5. Ejecutar pytest
echo "⚙️ Ejecutando pruebas..."
$PYTHON_BIN -m pytest tests/ --html=../reports/report.html --self-contained-html

echo "✅ Proceso terminado."