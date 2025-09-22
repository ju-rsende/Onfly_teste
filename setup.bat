@echo off
echo ========================================
echo  N8N Random Node - Setup Automatico
echo ========================================
echo.

echo [1/4] Instalando dependencias do conector...
cd n8n-custom-node
call npm install
if %errorlevel% neq 0 (
    echo ERRO: Falha ao instalar dependencias
    pause
    exit /b 1
)

echo [2/4] Compilando conector personalizado...
call npm run build
if %errorlevel% neq 0 (
    echo ERRO: Falha ao compilar conector
    pause
    exit /b 1
)

echo [3/4] Subindo infraestrutura Docker...
cd ..\docker-compose
docker-compose up -d
if %errorlevel% neq 0 (
    echo ERRO: Falha ao subir Docker Compose
    pause
    exit /b 1
)

echo [4/4] Aguardando n8n inicializar...
timeout /t 10 /nobreak > nul

echo.
echo ========================================
echo  Setup concluido com sucesso!
echo ========================================
echo.
echo N8N esta rodando em: http://localhost:5678
echo Usuario: admin
echo Senha: admin123
echo.
echo Para parar os servicos: docker-compose down
echo.
pause