# N8N Random Number Generator - Conector Personalizado

Este projeto implementa um conector personalizado para o n8n que gera números aleatórios verdadeiros usando a API do Random.org.

## 🚀 Funcionalidades

- **Conector Random**: Gera números aleatórios verdadeiros
- **Operação**: "True Random Number Generator"
- **Parâmetros**: Min e Max (números inteiros inclusos)
- **API**: Integração com Random.org

## 📋 Pré-requisitos

- Node.js 22 (LTS)
- Docker e Docker Compose
- npm ou yarn

## 🛠️ Instalação e Configuração

### 1. Clone e configure o projeto

```bash
git clone <seu-repositorio>
cd Onfly_teste
```

### 2. Instale as dependências do conector personalizado

```bash
cd n8n-custom-node
npm install
npm run build
```

### 3. Suba a infraestrutura do n8n

```bash
cd ../docker-compose
docker-compose up -d
```

### 4. Acesse o n8n

Abra seu navegador e acesse: http://localhost:5678

## 📁 Estrutura do Projeto

```
Onfly_teste/
├── docker-compose/
│   ├── docker-compose.yml
│   └── .env
├── n8n-custom-node/
│   ├── nodes/
│   │   └── Random/
│   │       ├── Random.node.ts
│   │       └── random.svg
│   ├── package.json
│   ├── tsconfig.json
│   └── README.md
└── README.md
```

## 🔧 Como usar o conector

1. No n8n, adicione um novo nó
2. Procure por "Random" na lista de nós
3. Configure os parâmetros:
   - **Min**: Número mínimo (ex: 1)
   - **Max**: Número máximo (ex: 100)
4. Execute o workflow

## 🐳 Docker Compose

O projeto inclui:
- n8n (versão 1.85.4)
- PostgreSQL como banco de dados
- Volume para conectores personalizados

## 📝 Desenvolvimento

Para modificar o conector:

1. Edite os arquivos em `n8n-custom-node/nodes/Random/`
2. Execute `npm run build`
3. Reinicie o container do n8n: `docker-compose restart n8n`

## 🔍 Troubleshooting

- Verifique se o Docker está rodando
- Confirme se a porta 5678 está disponível
- Verifique os logs: `docker-compose logs n8n`