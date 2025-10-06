# Boas Práticas com IA

Guia para trabalhar efetivamente com ferramentas de IA no desenvolvimento de software.

## Introdução

Ferramentas de IA como GitHub Copilot, ChatGPT, Claude e outras estão revolucionando o desenvolvimento. Este guia apresenta boas práticas para maximizar produtividade mantendo qualidade.

## Princípios Fundamentais

### 1. IA como Assistente, não Substituto

- ✅ Use IA para acelerar tarefas repetitivas
- ✅ Revise e entenda TODO código gerado
- ❌ Não copie código sem compreender
- ❌ Não confie cegamente em sugestões

### 2. Contexto é Tudo

Quanto melhor o contexto, melhor a resposta da IA.

**Forneça:**
- Descrição clara do problema
- Tecnologias sendo usadas
- Código relevante existente
- Requisitos específicos
- Restrições e limitações

### 3. Iteração e Refinamento

- Primeira resposta raramente é perfeita
- Faça perguntas de acompanhamento
- Peça alternativas quando necessário
- Refine instruções baseado nos resultados

## Casos de Uso Efetivos

### ✅ Ótimo para:

#### 1. Boilerplate e Código Repetitivo

```javascript
// Prompt: "Criar um componente React de formulário de login"
// IA gera estrutura básica que você customiza
```

#### 2. Documentação

```javascript
// Prompt: "Adicionar JSDoc a esta função"
/**
 * Calcula o total do carrinho com descontos
 * @param {Array} items - Lista de itens
 * @param {number} discount - Percentual de desconto
 * @returns {number} Total calculado
 */
```

#### 3. Testes Unitários

```javascript
// Prompt: "Criar testes para esta função"
// IA gera casos de teste básicos que você expande
```

#### 4. Refatoração

```javascript
// Prompt: "Refatorar esta função para ser mais legível"
// IA sugere melhorias mantendo funcionalidade
```

#### 5. Debugging

```javascript
// Prompt: "Por que este código está dando erro X?"
// IA ajuda identificar problema
```

#### 6. Aprendizado

```javascript
// Prompt: "Explicar como funciona async/await"
// IA fornece explicação clara com exemplos
```

### ⚠️ Use com Cautela:

- Lógica de negócio complexa
- Código de segurança crítica
- Algoritmos específicos do domínio
- Decisões arquiteturais importantes

## Prompts Efetivos

### Estrutura de um Bom Prompt

```
[CONTEXTO] + [TAREFA] + [RESTRIÇÕES] + [FORMATO DESEJADO]
```

### Exemplos

#### ❌ Ruim

```
"Criar uma API"
```

#### ✅ Bom

```
"Criar uma API REST em Node.js/Express para gerenciar usuários.
Deve incluir:
- Endpoints: GET, POST, PUT, DELETE
- Validação com Joi
- Autenticação JWT
- Tratamento de erros
- TypeScript
Retornar apenas o código sem explicações."
```

### Templates Úteis

#### Para Código

```
Linguagem: [JavaScript/Python/etc]
Framework: [React/Express/etc]
Tarefa: [descrição clara]
Requisitos: [lista de requisitos]
Estilo: [padrões de código a seguir]
```

#### Para Debug

```
Problema: [descrição do erro]
Código: [código relevante]
Comportamento esperado: [o que deveria acontecer]
Comportamento atual: [o que está acontecendo]
Erro: [mensagem de erro se houver]
```

#### Para Explicação

```
Conceito: [o que você quer entender]
Nível: [iniciante/intermediário/avançado]
Contexto: [onde você vai usar]
Formato: [explicação + exemplo prático]
```

## Workflow Recomendado

### 1. Preparação

```
1. Defina claramente o problema
2. Reúna contexto relevante
3. Identifique requisitos específicos
```

### 2. Consulta à IA

```
1. Escreva prompt detalhado
2. Obtenha primeira resposta
3. Refine se necessário
```

### 3. Revisão

```
1. Leia e entenda o código
2. Teste funcionalidade
3. Verifique edge cases
4. Adapte ao estilo do projeto
```

### 4. Integração

```
1. Integre ao código existente
2. Execute testes
3. Faça code review
4. Documente se necessário
```

## Armadilhas Comuns

### 1. Código Desatualizado

**Problema:** IA pode sugerir práticas antigas ou deprecated.

**Solução:**
- Especifique versões no prompt
- Verifique documentação oficial
- Mantenha-se atualizado com releases

```
# ❌ Evite
"Como fazer requisição HTTP em JavaScript?"

# ✅ Prefira
"Como fazer requisição HTTP em JavaScript usando fetch API (ES6+)?"
```

### 2. Sobre-engenharia

**Problema:** IA pode gerar soluções excessivamente complexas.

**Solução:**
- Peça soluções simples explicitamente
- Questione complexidade desnecessária
- Use princípio KISS (Keep It Simple)

```
# ✅ Adicione ao prompt
"Solução mais simples possível, sem over-engineering"
```

### 3. Falta de Tratamento de Erros

**Problema:** Código gerado pode não tratar erros adequadamente.

**Solução:**
- Adicione sempre tratamento de erros
- Teste cenários de falha
- Valide inputs

```javascript
// ❌ Código da IA sem tratamento
async function fetchUser(id) {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

// ✅ Versão melhorada
async function fetchUser(id) {
  try {
    if (!id) throw new Error('ID is required');

    const response = await fetch(`/api/users/${id}`);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error('Failed to fetch user:', error);
    throw error;
  }
}
```

### 4. Segurança

**Problema:** IA pode gerar código com vulnerabilidades.

**Solução:**
- Nunca confie em código de segurança sem revisar
- Valide inputs
- Sanitize outputs
- Use bibliotecas testadas

```javascript
// ❌ Código inseguro da IA
app.get('/user', (req, res) => {
  const query = `SELECT * FROM users WHERE id = ${req.query.id}`;
  // SQL Injection vulnerability!
});

// ✅ Código seguro
app.get('/user', (req, res) => {
  const query = 'SELECT * FROM users WHERE id = ?';
  db.query(query, [req.query.id], (err, results) => {
    // Parametrized query prevents SQL injection
  });
});
```

## Ferramentas de IA

### GitHub Copilot

**Melhor para:**
- Autocompletar código
- Gerar funções simples
- Escrever testes

**Dicas:**
- Escreva comentários descritivos antes do código
- Use nomes de variáveis/funções claros
- Revise sugestões antes de aceitar

### ChatGPT / Claude

**Melhor para:**
- Explicações conceituais
- Debugging complexo
- Refatoração
- Geração de documentação

**Dicas:**
- Forneça contexto completo
- Faça perguntas específicas
- Itere sobre respostas

### Tabnine / Codeium

**Melhor para:**
- Autocompletar baseado no projeto
- Sugestões contextuais

## Checklist de Revisão

Ao usar código gerado por IA, verifique:

- [ ] Entendo completamente o código?
- [ ] Código segue padrões do projeto?
- [ ] Há tratamento de erros adequado?
- [ ] Edge cases são cobertos?
- [ ] Não há vulnerabilidades de segurança?
- [ ] Performance é aceitável?
- [ ] Código está testado?
- [ ] Documentação está adequada?
- [ ] Não há dependências desnecessárias?
- [ ] TypeScript types estão corretos?

## Limites Éticos

### ❌ NÃO use IA para:

- Copiar código proprietário
- Violar licenças de software
- Gerar código malicioso
- Plagiar sem atribuição
- Burlar sistemas de segurança

### ✅ Use IA de forma ética:

- Respeite licenças de código
- Dê crédito quando apropriado
- Revise e entenda antes de usar
- Considere privacidade de dados
- Siga políticas da empresa

## Produtividade vs. Qualidade

### Encontre o Equilíbrio

```
🚀 Produtividade (IA)
    ↕️
    Balanceamento
    ↕️
🎯 Qualidade (Revisão Humana)
```

### Regras de Ouro

1. **Use IA para acelerar**, não para substituir pensamento
2. **Sempre revise** código gerado
3. **Entenda antes de usar**
4. **Teste adequadamente**
5. **Mantenha padrões** do projeto

## Casos Práticos

### Exemplo 1: Criar Componente React

```markdown
Prompt:
"Criar componente React funcional de card de produto com:
- Props: title, price, image, description
- Botão 'Adicionar ao Carrinho'
- Styled components
- TypeScript
- Responsivo"

Resultado: IA gera estrutura base
Ação: Revisar, ajustar estilos, adicionar lógica de negócio
```

### Exemplo 2: Debugging

```markdown
Problema: "useEffect executando infinitamente"

Prompt:
"Por que este useEffect está em loop infinito?
[colar código]
Como corrigir mantendo funcionalidade?"

Resultado: IA identifica array de dependências
Ação: Implementar correção e testar
```

### Exemplo 3: Refatoração

```markdown
Código: Função com 200 linhas, muito complexa

Prompt:
"Refatorar esta função seguindo:
- Single Responsibility Principle
- Extrair lógica em funções menores
- Melhorar legibilidade
- Manter mesma funcionalidade"

Resultado: IA sugere estrutura modular
Ação: Revisar, testar, ajustar
```

## Recursos Adicionais

- [GitHub Copilot Docs](https://docs.github.com/copilot)
- [OpenAI Best Practices](https://platform.openai.com/docs/guides/prompt-engineering)
- [Prompt Engineering Guide](https://www.promptingguide.ai/)
