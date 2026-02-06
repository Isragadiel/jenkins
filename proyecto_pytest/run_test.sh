#!/bin/bash

echo "activando el entorno virtual"
if [!"-d venv"]; then 
    python3 -m venv venv
fi
source venv/bin/activate

echo "instalado dependencias"
pip install --upgrade pip
pip install -r requirements.txt

echo "ejecutando pruebas con pytest"
pytest tests/ --junitxml=reports/test-results.xml --html=reports/test-results.html --self-contained-html

echo "prueas finalizadas reultados en reports"
