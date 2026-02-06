#!/bin/bash
echo "🚀 Iniciando ejecución de pruebas en Jenkins..."

# 1. Intentar crear el entorno virtual
if [ ! -d "venv" ]; then
    echo "📦 Intentando crear entorno virtual..."
    python3 -m venv venv || echo "⚠️ No se pudo crear venv (falta python3-venv en el sistema)"
fi

# 2. Intentar activar o usar pip directamente
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    PYTHON_EXE="python"
else
    echo "⚠️ Usando Python del sistema porque el venv no está disponible."
    PYTHON_EXE="python3"
fi

# 3. Instalación de dependencias
echo "📥 Instalando dependencias..."
$PYTHON_EXE -m pip install --upgrade pip
$PYTHON_EXE -m pip install pytest pytest-html -r requirements.txt

# 4. CRUCIAL: Crear la carpeta de reportes donde Jenkins la espera
# Si tu script corre dentro de 'proyecto_pytest', subimos un nivel
mkdir -p ../reports

# 5. Ejecutar pruebas
echo "⚙️ Ejecutando pruebas con pytest..."
$PYTHON_EXE -m pytest tests/ --junitxml=../reports/test-results.xml --html=../reports/report.html --self-contained-html

echo "✅ Pruebas finalizadas."