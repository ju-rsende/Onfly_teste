# 🎯 N8N Random Number Generator - Guia Completo

Este guia documenta todo o processo de criação, instalação e uso do conector personalizado Random para n8n.

## 📋 Visão Geral

**Objetivo:** Criar um conector personalizado para n8n que gera números aleatórios verdadeiros usando a API do Random.org.

**Tecnologias:**
- Node.js 22 + TypeScript
- Docker + Docker Compose
- n8n 1.85.4
- PostgreSQL 15
- Random.org API

## 🚀 Passo a Passo Completo

### 1. Estrutura do Projeto

```
Onfly_teste/
├── docker-compose/          # Infraestrutura
│   ├── docker-compose.yml   # n8n + PostgreSQL
│   ├── .env                 # Variáveis de ambiente
│   └── README.md
├── n8n-custom-node/         # Conector personalizado
│   ├── nodes/Random/        # Implementação
│   │   ├── Random.node.ts   # Código principal
│   │   └── random.svg       # Ícone SVG
│   ├── package.json         # Dependências
│   ├── tsconfig.json        # Config TypeScript
│   └── gulpfile.js          # Build ícones
├── README.md                # Documentação principal
├── setup.bat                # Script automático
└── GUIA_COMPLETO.md         # Este arquivo
```

### 2. Instalação do Docker Desktop

#### Opção 1: Script Automático
```cmd
install-docker-manual.bat
```

#### Opção 2: Manual
1. Acesse: https://www.docker.com/products/docker-desktop/
2. Baixe "Docker Desktop for Windows"
3. Execute o instalador
4. Reinicie o computador
5. Abra Docker Desktop

#### Verificação
```cmd
docker --version
```

### 3. Compilação do Conector

```cmd
cd n8n-custom-node
npm install
npm run build
```

**Arquivos gerados:**
- `dist/Random.node.js` - Conector compilado
- `dist/nodes/Random/random.svg` - Ícone

### 4. Execução da Infraestrutura

#### Opção 1: Script Completo
```cmd
setup.bat
```

#### Opção 2: Manual
```cmd
cd docker-compose
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose up -d
```

### 5. Verificação dos Containers

```cmd
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose ps
```

**Saída esperada:**
```
NAME                        STATUS                    PORTS
docker-compose-n8n-1        Up                       0.0.0.0:5678->5678/tcp
docker-compose-postgres-1   Up (healthy)             5432/tcp
```

### 6. Acesso ao n8n

**URL:** http://localhost:5678

**Configuração:** Sem autenticação (acesso direto)

## 🎯 Usando o Conector Random

### 1. Criando um Workflow

1. Acesse http://localhost:5678
2. Clique em "New Workflow"
3. Adicione os nós na seguinte ordem:

### 2. Estrutura do Workflow

```
[Manual Trigger] → [Random] → [Set/Output]
```

### 3. Configuração do Nó Random

**Parâmetros:**
- **Operation:** "True Random Number Generator" (padrão)
- **Minimum Value:** 1 (ou qualquer número mínimo)
- **Maximum Value:** 100 (ou qualquer número máximo)

### 4. Output do Conector

```json
{
  "randomNumber": 42,
  "min": 1,
  "max": 100,
  "source": "random.org",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### 5. Exemplo de Workflow Completo

1. **Manual Trigger**
   - Permite execução manual

2. **Random**
   - Min: 1
   - Max: 100

3. **Set** (para visualizar resultado)
   - Campo: `result`
   - Valor: `{{$json.randomNumber}}`

## 🔧 Troubleshooting

### Docker não encontrado
```cmd
# Verificar instalação
where docker

# Usar caminho completo
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" --version
```

### Containers não sobem
```cmd
# Verificar logs
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose logs

# Reiniciar
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose restart
```

### N8N não responde
```cmd
# Testar conectividade
powershell -Command "Invoke-WebRequest -Uri 'http://localhost:5678'"

# Verificar porta
netstat -ano | findstr :5678
```

### Conector não aparece
1. Verificar se `dist/Random.node.js` existe
2. Reiniciar container n8n:
```cmd
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose restart n8n
```

## 🧪 Execução de Testes

### 1. Testes do Conector

#### Teste de Compilação
```cmd
cd n8n-custom-node
npm run build
```
**Resultado esperado:** Arquivos gerados em `dist/`

#### Teste de Linting
```cmd
npm run lint
```
**Resultado esperado:** Sem erros de código

### 2. Testes de Infraestrutura

#### Teste Docker
```cmd
# Verificar Docker funcionando
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" --version

# Testar pull de imagens
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" pull hello-world
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" run hello-world
```

#### Teste Containers
```cmd
cd docker-compose

# Subir containers
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose up -d

# Verificar status
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose ps

# Verificar logs
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose logs
```

### 3. Testes de Conectividade

#### Teste N8N
```cmd
# Testar resposta HTTP
powershell -Command "Invoke-WebRequest -Uri 'http://localhost:5678'"

# Testar porta
netstat -ano | findstr :5678
```

#### Teste PostgreSQL
```cmd
# Verificar container postgres
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" exec docker-compose-postgres-1 pg_isready -U n8n
```

### 4. Testes Funcionais do Conector

#### Teste Manual no N8N
1. Acesse http://localhost:5678
2. Crie workflow: `Manual Trigger → Random → Set`
3. Configure Random:
   - Min: 1
   - Max: 10
4. Execute 5 vezes
5. **Validar:** Números diferentes entre 1-10

#### Teste API Random.org
```cmd
# Testar API diretamente
powershell -Command "Invoke-WebRequest -Uri 'https://www.random.org/integers/?num=1&min=1&max=100&col=1&base=10&format=plain&rnd=new'"
```

### 5. Testes de Validação

#### Teste Parâmetros Inválidos
1. Configure Random com Min > Max (ex: Min=100, Max=1)
2. Execute workflow
3. **Resultado esperado:** Erro "Minimum value cannot be greater than maximum value"

#### Teste Limites
1. Teste Min=Max (ex: ambos = 50)
2. **Resultado esperado:** Sempre retorna 50
3. Teste valores extremos (Min=-1000, Max=1000)
4. **Resultado esperado:** Número no intervalo

### 6. Testes de Performance

#### Teste Múltiplas Execuções
1. Crie workflow com loop de 10 execuções
2. Monitore tempo de resposta
3. **Resultado esperado:** < 2s por execução

#### Teste Carga
```cmd
# Múltiplas requisições simultâneas
powershell -Command "1..5 | ForEach-Object { Start-Job { Invoke-WebRequest 'http://localhost:5678' } }"
```

### 7. Checklist de Testes

**Pré-requisitos:**
- [ ] Docker Desktop funcionando
- [ ] Containers rodando (postgres + n8n)
- [ ] N8N acessível

**Testes Básicos:**
- [ ] Conector compila sem erros
- [ ] Conector aparece na lista de nós
- [ ] Workflow executa com sucesso
- [ ] Números gerados estão no intervalo
- [ ] API Random.org responde

**Testes Avançados:**
- [ ] Validação de parâmetros funciona
- [ ] Tratamento de erros adequado
- [ ] Performance aceitável
- [ ] Múltiplas execuções funcionam
- [ ] Output tem formato correto

**Resultado dos Testes:**
```json
{
  "randomNumber": 42,
  "min": 1,
  "max": 100,
  "source": "random.org",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## 🛑 Parando o Projeto

```cmd
cd docker-compose
"C:\Program Files\Docker\Docker\resources\bin\docker.exe" compose down
```

## 📝 Detalhes Técnicos

### Conector Random

**Arquivo:** `n8n-custom-node/nodes/Random/Random.node.ts`

**Funcionalidades:**
- Integração obrigatória com Random.org API
- Validação de parâmetros (Min ≤ Max)
- Tratamento de erros robusto
- Output estruturado com metadados

**API Endpoint:**
```
https://www.random.org/integers/?num=1&min={min}&max={max}&col=1&base=10&format=plain&rnd=new
```

### Docker Compose

**Serviços:**
- **PostgreSQL 15:** Banco de dados do n8n
- **n8n 1.85.4:** Plataforma de automação
- **Volumes:** Persistência de dados e conectores personalizados

**Configuração:**
- Porta n8n: 5678
- Autenticação: Desabilitada
- Volume custom: `../n8n-custom-node:/home/node/.n8n/custom`

## Resultado Final

**Conector Random funcional** que:
- ✅ Gera números aleatórios verdadeiros
- ✅ Usa API Random.org obrigatoriamente
- ✅ Valida parâmetros de entrada
- ✅ Retorna dados estruturados
- ✅ Integra perfeitamente com n8n
- ✅ Segue melhores práticas de desenvolvimento
