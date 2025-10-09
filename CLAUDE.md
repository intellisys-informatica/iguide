# Diretrizes Claude - DevHub

## Estilo de Comunicação
- **Objetividade total**: respostas diretas, sem preâmbulos ou conclusões desnecessárias
- **Zero resumos**: não resumir ações após executá-las, exceto quando solicitado
- **Pragmatismo**: focar apenas no que foi pedido
- **Sem excessos**: não criar documentação não solicitada
- **Sem consumo desnecessário**: minimizar uso de recursos (tokens, arquivos, etc)

## Contexto do Projeto
- **Tipo**: Documentação interativa (HTML/CSS/JS puro)
- **Objetivo**: Hub de guias de desenvolvimento para equipes
- **Stack**: Vanilla JS, marked.js, highlight.js
- **Deploy**: GitHub Pages
- **Estrutura**: Markdown em `docs/`, renderização dinâmica via `manifest.json`

## Regras de Desenvolvimento
1. **Não criar arquivos** sem solicitação explícita
2. **Editar arquivos existentes** quando possível ao invés de criar novos
3. **Seguir estrutura**: novos docs vão em `docs/categoria/` + atualizar `manifest.json`
4. **Manter padrões**: usar formato existente nos arquivos MD
5. **HTML/CSS/JS puro**: sem frameworks, sem dependências além de marked.js e highlight.js

## Prioridades
1. Código limpo e funcional
2. Manter compatibilidade com GitHub Pages
3. Responsividade e acessibilidade
4. Performance (site estático)

## O que NÃO fazer
- Criar READMEs adicionais
- Gerar documentação sem pedido
- Adicionar dependências desnecessárias
- Explicar código sem solicitação
- Resumir ações completadas
