@echo off
echo ========================================
echo  Instalacao Automatica do Docker Desktop
echo ========================================
echo.

echo [1/3] Baixando Docker Desktop...
powershell -Command "Invoke-WebRequest -Uri 'https://desktop.docker.com/win/main/amd64/Docker%%20Desktop%%20Installer.exe' -OutFile 'Docker-Desktop-Installer.exe'"

if not exist "Docker-Desktop-Installer.exe" (
    echo ERRO: Falha ao baixar Docker Desktop
    pause
    exit /b 1
)

echo [2/3] Instalando Docker Desktop...
echo ATENCAO: A instalacao pode demorar alguns minutos...
start /wait Docker-Desktop-Installer.exe install --quiet --accept-license

echo [3/3] Limpando arquivos temporarios...
del Docker-Desktop-Installer.exe

echo.
echo ========================================
echo  Docker Desktop instalado!
echo ========================================
echo.
echo IMPORTANTE:
echo 1. Reinicie o computador
echo 2. Abra o Docker Desktop
echo 3. Execute: setup.bat
echo.
pause