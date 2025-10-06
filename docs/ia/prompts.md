# Guia de Prompts

Exemplos práticos de prompts efetivos para diferentes cenários de desenvolvimento.

## Estrutura de Prompts

### Formula Básica

```
[PAPEL] + [CONTEXTO] + [TAREFA] + [FORMATO] + [RESTRIÇÕES]
```

### Exemplo Aplicado

```
[PAPEL] Você é um desenvolvedor React experiente.
[CONTEXTO] Estou construindo um e-commerce.
[TAREFA] Crie um componente de carrinho de compras.
[FORMATO] TypeScript + Styled Components.
[RESTRIÇÕES] Responsivo, acessível, sem bibliotecas externas de UI.
```

## Prompts por Categoria

## 1. Geração de Código

### Componente React

```
Crie um componente React funcional para [DESCRIÇÃO].

Requisitos:
- TypeScript com tipos bem definidos
- Props: [listar props]
- Estado: [descrever estado necessário]
- Estilização: [CSS Modules/Styled Components/Tailwind]
- Responsivo
- Acessível (ARIA labels)

Exemplo de uso no final.
```

**Exemplo concreto:**

```
Crie um componente React funcional para um formulário de login.

Requisitos:
- TypeScript com tipos bem definidos
- Props: onSubmit, isLoading, error
- Estado: email, password
- Estilização: Styled Components
- Validação de email
- Mostrar/ocultar senha
- Responsivo
- Acessível (ARIA labels)

Inclua exemplo de uso no final.
```

### API Endpoint

```
Crie um endpoint [METHOD] /api/[route] usando [framework].

Funcionalidade: [descrever]

Requisitos:
- Validação de entrada com [biblioteca]
- Autenticação: [JWT/OAuth/etc]
- Tratamento de erros completo
- TypeScript
- Comentários explicativos

Incluir:
- Controller
- Service (lógica de negócio)
- Types/Interfaces
- Testes unitários básicos
```

**Exemplo concreto:**

```
Crie um endpoint POST /api/users usando Express.js.

Funcionalidade: Criar novo usuário

Requisitos:
- Validação de entrada com Joi
- Hash de senha com bcrypt
- Autenticação: JWT
- Tratamento de erros completo
- TypeScript
- Comentários explicativos

Incluir:
- Controller
- Service (lógica de negócio)
- Types/Interfaces
- Exemplo de teste unitário com Jest
```

### Função Utilitária

```
Crie uma função utilitária em [linguagem] que [funcionalidade].

Input: [descrever]
Output: [descrever]

Requisitos:
- TypeScript com tipos genéricos se aplicável
- Tratamento de edge cases
- JSDoc completo
- Pure function (sem side effects)
- Testes unitários

Exemplos de uso.
```

## 2. Refatoração

### Simplificar Código

```
Refatore este código para:
- Melhorar legibilidade
- Reduzir complexidade
- Aplicar princípios SOLID
- Manter mesma funcionalidade

Código:
[colar código]

Explique as mudanças feitas.
```

### Modernizar Código

```
Modernize este código para usar [ES6+/TypeScript/etc]:

Código legado:
[colar código]

Aplicar:
- Arrow functions
- Destructuring
- Template literals
- Async/await
- Optional chaining

Manter compatibilidade com [navegadores/Node version].
```

### Extrair Lógica

```
Este código viola Single Responsibility Principle.
Refatore extraindo lógica em funções/classes menores.

Código:
[colar código]

Requisitos:
- Cada função faz apenas uma coisa
- Nomes descritivos
- Reutilizável
- Testável
```

## 3. Debugging

### Identificar Problema

```
Por que este código [comportamento inesperado]?

Código:
[colar código]

Comportamento esperado: [descrever]
Comportamento atual: [descrever]
Erro (se houver): [mensagem]

Explique o problema e forneça solução.
```

**Exemplo concreto:**

```
Por que este useEffect está executando infinitamente?

Código:
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetchUser(userId).then(setUser);
  }, [user]);

  return <div>{user?.name}</div>;
}

Comportamento esperado: Executar apenas quando userId mudar
Comportamento atual: Loop infinito
```

### Otimizar Performance

```
Este código está lento. Como otimizar?

Código:
[colar código]

Contexto:
- Volume de dados: [quantidade]
- Frequência de execução: [descrever]
- Performance atual: [tempo/recursos]
- Performance desejada: [objetivo]

Sugerir otimizações e explicar trade-offs.
```

## 4. Testes

### Testes Unitários

```
Crie testes unitários para esta função usando [Jest/Vitest/etc].

Função:
[colar código]

Cobrir:
- Casos normais (happy path)
- Edge cases
- Casos de erro
- Validação de inputs

Use describe/it e expect assertions.
```

### Testes de Integração

```
Crie testes de integração para este endpoint.

Endpoint:
[descrever ou colar código]

Cenários a testar:
- Requisição válida
- Requisição inválida
- Autenticação falhando
- Erro de servidor

Framework: [Supertest/etc]
Mock: [descrever o que mockar]
```

### Testes E2E

```
Crie testes E2E com [Playwright/Cypress] para:

Fluxo: [descrever user journey]

Passos:
1. [ação]
2. [ação]
3. [verificação]

Incluir:
- Setup
- Teardown
- Assertions
- Screenshots em falha
```

## 5. Documentação

### README

```
Crie um README.md profissional para este projeto:

Projeto: [nome e descrição]
Tech stack: [tecnologias]
Funcionalidades principais: [listar]

Incluir:
- Badges (build, coverage, etc)
- Descrição
- Screenshots/GIFs
- Instalação
- Uso
- API docs (se aplicável)
- Contribuição
- Licença
```

### JSDoc/TSDoc

```
Adicione documentação completa (JSDoc) para este código:

[colar código]

Incluir:
- Descrição da função/classe
- @param para cada parâmetro
- @returns para retorno
- @throws para exceções
- @example com uso prático
```

### API Documentation

```
Crie documentação de API para estes endpoints:

[listar endpoints]

Formato: Markdown

Para cada endpoint incluir:
- Método e rota
- Descrição
- Autenticação necessária
- Request body/params
- Response (success e error)
- Exemplos com curl
```

## 6. SQL e Banco de Dados

### Consultas SQL

```
Crie uma query SQL que [objetivo].

Estrutura das tabelas:
[descrever schema]

Requisitos:
- [filtros/joins/agregações]
- Otimizada para performance
- Comentários explicativos

Incluir índices recomendados.
```

### Migrations

```
Crie uma migration para [mudança no schema].

ORM: [Prisma/TypeORM/Sequelize/etc]

Mudanças:
- [descrever alterações]

Incluir:
- Migration up
- Migration down (rollback)
- Seed data se necessário
```

## 7. DevOps e CI/CD

### Dockerfile

```
Crie um Dockerfile otimizado para [tipo de aplicação].

Aplicação: [Node.js/Python/etc]
Requisitos:
- Multi-stage build
- Imagem pequena (Alpine se possível)
- Non-root user
- Health check
- .dockerignore apropriado

Incluir docker-compose.yml se necessário.
```

### GitHub Actions

```
Crie um workflow do GitHub Actions para:

Trigger: [push/PR/schedule]

Jobs:
- Lint
- Test
- Build
- Deploy (se aplicável)

Incluir:
- Cache de dependências
- Matrix strategy se necessário
- Secrets/env vars
```

## 8. Arquitetura

### Design Pattern

```
Implemente o padrão [nome do pattern] em [linguagem].

Cenário: [descrever problema a resolver]

Incluir:
- Estrutura completa
- Exemplos de uso
- Quando usar/não usar
- Vantagens e desvantagens
```

### Estrutura de Pastas

```
Sugira estrutura de pastas para [tipo de projeto].

Stack: [tecnologias]
Escala: [pequeno/médio/grande]

Requisitos:
- Escalável
- Organizado por feature/tipo
- Fácil de navegar

Explicar propósito de cada pasta.
```

## 9. Específicos de Framework

### React Hooks

```
Crie um custom hook chamado use[Nome].

Funcionalidade: [descrever]

Requisitos:
- TypeScript
- Memoização quando apropriado
- Cleanup quando necessário
- Retornar [descrever]

Incluir exemplo de uso em componente.
```

### Next.js API Route

```
Crie uma API route do Next.js para [funcionalidade].

Rota: /api/[...]

Suportar:
- GET, POST, PUT, DELETE
- Validação de método
- Autenticação com NextAuth
- TypeScript
- Tratamento de erros

Incluir tipos para request/response.
```

## 10. Segurança

### Validação e Sanitização

```
Adicione validação e sanitização completa para este input:

[colar código de input]

Validar:
- Tipo de dados
- Formato
- Tamanho
- Caracteres permitidos

Prevenir:
- XSS
- SQL Injection
- Command Injection

Usar [Joi/Zod/class-validator/etc]
```

### Autenticação

```
Implemente autenticação [JWT/OAuth/etc] em [framework].

Requisitos:
- Login endpoint
- Token generation/validation
- Refresh token
- Middleware de autenticação
- Tratamento de expiração
- TypeScript

Incluir exemplos de uso.
```

## Templates Prontos

### Template Genérico

```
Contexto: [descrever situação]
Objetivo: [o que você quer alcançar]
Stack: [tecnologias]
Restrições: [limitações]
Formato desejado: [código/explicação/ambos]
```

### Template de Debug

```
Problema: [sintoma]
Código: [colar aqui]
Esperado: [comportamento correto]
Atual: [comportamento incorreto]
Erro: [mensagem se houver]
Já tentei: [o que você já fez]
```

### Template de Aprendizado

```
Tópico: [conceito a aprender]
Meu nível: [iniciante/intermediário/avançado]
Contexto: [onde vou usar]
Prefiro: [explicação teórica/exemplo prático/ambos]
Linguagem: [se aplicável]
```

## Dicas para Melhores Prompts

### 1. Seja Específico

❌ "Crie uma API"
✅ "Crie uma API REST em Node.js/Express para CRUD de produtos com TypeScript e autenticação JWT"

### 2. Forneça Contexto

❌ "Como corrigir este erro?"
✅ "Como corrigir este erro de CORS em Next.js API route ao fazer requisição de localhost:3000 para localhost:3001?"

### 3. Defina Formato

❌ "Explique React hooks"
✅ "Explique React hooks com 3 exemplos práticos de código comentado, nível intermediário"

### 4. Liste Requisitos

```
Requisitos obrigatórios:
- [ ] TypeScript
- [ ] Testes
- [ ] Documentação

Opcional:
- [ ] Exemplos de uso
```

### 5. Itere

```
Prompt 1: "Crie componente de modal"
Resposta: [código básico]

Prompt 2: "Adicione animação de fade in/out"
Prompt 3: "Torne acessível com trap de foco"
Prompt 4: "Adicione suporte a backdrop click para fechar"
```

## Recursos Adicionais

- [Prompt Engineering Guide](https://www.promptingguide.ai/)
- [OpenAI Best Practices](https://platform.openai.com/docs/guides/prompt-engineering)
- [Awesome ChatGPT Prompts](https://github.com/f/awesome-chatgpt-prompts)
