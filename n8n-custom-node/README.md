# N8N Random Node

Um conector personalizado para o n8n que gera números aleatórios verdadeiros usando a API do Random.org.

## 🎯 Funcionalidades

- **Geração de números aleatórios verdadeiros**: Utiliza a API do Random.org para garantir aleatoriedade real
- **Parâmetros configuráveis**: Define valores mínimo e máximo
- **Validação de entrada**: Verifica se os parâmetros são válidos
- **Tratamento de erros**: Gerencia falhas de API e validação

## 📦 Instalação

### Desenvolvimento Local

1. Instale as dependências:
```bash
npm install
```

2. Compile o projeto:
```bash
npm run build
```

3. O nó compilado estará disponível em `dist/nodes/Random/Random.node.js`

### Uso com n8n

Este nó é automaticamente carregado quando o volume do Docker é montado corretamente no docker-compose.

## 🔧 Configuração

### Parâmetros do Nó

- **Minimum Value**: Valor mínimo para o número aleatório (inclusivo)
- **Maximum Value**: Valor máximo para o número aleatório (inclusivo)

### Saída

O nó retorna um objeto JSON com:
```json
{
  "randomNumber": 42,
  "min": 1,
  "max": 100,
  "source": "random.org",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## 🌐 API Random.org

Este nó utiliza o endpoint público do Random.org:
```
https://www.random.org/integers/?num=1&min={min}&max={max}&col=1&base=10&format=plain&rnd=new
```

## 🛠️ Desenvolvimento

### Scripts Disponíveis

- `npm run build`: Compila TypeScript e copia ícones
- `npm run dev`: Modo de desenvolvimento com watch
- `npm run lint`: Executa linting
- `npm run format`: Formata código com Prettier

### Estrutura de Arquivos

```
nodes/Random/
├── Random.node.ts    # Implementação principal do nó
└── random.svg        # Ícone do nó
```

## 🔍 Troubleshooting

### Problemas Comuns

1. **Nó não aparece no n8n**: Verifique se o volume está montado corretamente
2. **Erro de compilação**: Execute `npm install` e `npm run build`
3. **API não responde**: Verifique conectividade com Random.org

### Logs

Para debug, verifique os logs do container n8n:
```bash
docker-compose logs n8n
```