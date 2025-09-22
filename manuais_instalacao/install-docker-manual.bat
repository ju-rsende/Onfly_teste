@echo off
echo ========================================
echo  Instalacao Manual do Docker Desktop
echo ========================================
echo.

echo Baixando Docker Desktop...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://desktop.docker.com/win/main/amd64/Docker Desktop Installer.exe' -OutFile 'DockerDesktopInstaller.exe'}"

if exist "DockerDesktopInstaller.exe" (
    echo Download concluido!
    echo.
    echo Executando instalador...
    echo IMPORTANTE: Aceite todas as opcoes padrao
    start /wait DockerDesktopInstaller.exe
    
    echo.
    echo Limpando arquivo temporario...
    del DockerDesktopInstaller.exe
    
    echo.
    echo ========================================
    echo  Instalacao concluida!
    echo ========================================
    echo.
    echo PROXIMOS PASSOS:
    echo 1. Abra o Docker Desktop
    echo 2. Aguarde inicializacao completa
    echo 3. Execute: setup.bat
    echo.
) else (
    echo ERRO: Falha no download
    echo.
    echo Alternativa manual:
    echo 1. Acesse: https://www.docker.com/products/docker-desktop/
    echo 2. Baixe Docker Desktop for Windows
    echo 3. Execute o instalador
    echo 4. Reinicie o computador
    echo 5. Execute: setup.bat
)

pause