# Docker Compose - N8N com PostgreSQL

Esta configuração Docker Compose sobe uma instância completa do n8n com banco PostgreSQL e suporte a conectores personalizados.

## 🚀 Como usar

### 1. Inicie os serviços

```bash
docker-compose up -d
```

### 2. Acesse o n8n

Abra seu navegador em: http://localhost:5678

**Credenciais padrão:**
- Usuário: `admin`
- Senha: `admin123`

### 3. Pare os serviços

```bash
docker-compose down
```

## 🔧 Configuração

### Variáveis de Ambiente (.env)

- `POSTGRES_DB`: Nome do banco de dados
- `POSTGRES_USER`: Usuário do PostgreSQL
- `POSTGRES_PASSWORD`: Senha do PostgreSQL
- `N8N_BASIC_AUTH_USER`: Usuário do n8n
- `N8N_BASIC_AUTH_PASSWORD`: Senha do n8n

### Volumes

- `n8n_data`: Dados persistentes do n8n
- `postgres_data`: Dados do banco PostgreSQL
- `../n8n-custom-node`: Conectores personalizados

## 🐳 Serviços

### PostgreSQL
- **Imagem**: postgres:15
- **Porta**: 5432 (interna)
- **Health Check**: Verificação de disponibilidade

### N8N
- **Imagem**: n8nio/n8n:1.85.4
- **Porta**: 5678
- **Dependências**: PostgreSQL
- **Conectores**: Carregados de `../n8n-custom-node`

## 🔍 Troubleshooting

### Verificar logs
```bash
docker-compose logs n8n
docker-compose logs postgres
```

### Reiniciar serviços
```bash
docker-compose restart n8n
```

### Limpar volumes (CUIDADO: apaga dados)
```bash
docker-compose down -v
```