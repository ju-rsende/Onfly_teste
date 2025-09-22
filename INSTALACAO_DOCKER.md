# 🐳 Instalação do Docker para Windows

Para executar o projeto n8n, você precisa instalar o Docker Desktop.

## 📥 Download e Instalação

### 1. Baixe o Docker Desktop
- Acesse: https://www.docker.com/products/docker-desktop/
- Clique em "Download for Windows"
- Execute o instalador baixado

### 2. Configuração Inicial
- Durante a instalação, mantenha as opções padrão marcadas
- Reinicie o computador quando solicitado
- Abra o Docker Desktop após a instalação

### 3. Verificação
Abra o Command Prompt e execute:
```cmd
docker --version
docker-compose --version
```

## 🚀 Executar o Projeto

Após instalar o Docker:

```cmd
cd docker-compose
docker compose up -d
```

Ou execute o script automatizado:
```cmd
setup.bat
```

## 🌐 Acesso ao n8n

- URL: http://localhost:5678
- Usuário: admin  
- Senha: admin123

## ⚠️ Troubleshooting

### Docker não inicia
- Verifique se a virtualização está habilitada no BIOS
- Certifique-se de que o Hyper-V está ativado no Windows

### Porta 5678 ocupada
```cmd
netstat -ano | findstr :5678
```

### Parar os serviços
```cmd
docker compose down
```