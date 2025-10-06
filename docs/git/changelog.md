# Changelog

Guia completo sobre como escrever e manter changelogs efetivos.

## O que é um Changelog?

Um changelog é um arquivo que contém uma lista **curada e cronológica** de mudanças notáveis para cada versão de um projeto.

## Por que manter um Changelog?

- ✅ Facilita acompanhar mudanças entre versões
- ✅ Ajuda usuários a decidir se devem atualizar
- ✅ Demonstra profissionalismo e cuidado com o projeto
- ✅ Economiza tempo em suporte (menos perguntas sobre mudanças)

## Formato Padrão: Keep a Changelog

Seguimos o formato [Keep a Changelog](https://keepachangelog.com/).

### Estrutura Básica

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- New feature X

## [1.2.0] - 2024-03-15

### Added
- Feature A
- Feature B

### Changed
- Updated behavior of Y

### Fixed
- Bug in component Z

## [1.1.0] - 2024-02-01

...
```

## Categorias de Mudanças

### `Added` - Adicionado

Novas funcionalidades.

```markdown
### Added
- User authentication with OAuth 2.0
- Dark mode toggle in settings
- Export data to CSV functionality
```

### `Changed` - Modificado

Mudanças em funcionalidades existentes.

```markdown
### Changed
- Improved performance of search algorithm
- Updated UI design for better accessibility
- Changed default timeout from 30s to 60s
```

### `Deprecated` - Descontinuado

Funcionalidades que serão removidas em versões futuras.

```markdown
### Deprecated
- `/api/v1/users` endpoint (use `/api/v2/users` instead)
- `getUserData()` method (replaced by `fetchUserProfile()`)
```

### `Removed` - Removido

Funcionalidades que foram removidas.

```markdown
### Removed
- Support for Internet Explorer 11
- Legacy authentication system
- Deprecated `/api/v1` endpoints
```

### `Fixed` - Corrigido

Correções de bugs.

```markdown
### Fixed
- Login redirect loop on expired session
- Memory leak in image processing
- Incorrect total calculation in shopping cart
```

### `Security` - Segurança

Vulnerabilidades de segurança corrigidas.

```markdown
### Security
- Fixed XSS vulnerability in comment system
- Patched SQL injection in search endpoint
- Updated dependencies with known vulnerabilities
```

## Versionamento Semântico

### Formato: MAJOR.MINOR.PATCH

```
v2.3.1
│ │ │
│ │ └─── PATCH: Bug fixes
│ └───── MINOR: New features (backward compatible)
└─────── MAJOR: Breaking changes
```

### Quando incrementar cada número

| Tipo | Quando usar | Exemplo |
|------|-------------|---------|
| **PATCH** | Bug fixes, pequenas correções | `1.0.0` → `1.0.1` |
| **MINOR** | Novas features (compatível) | `1.0.0` → `1.1.0` |
| **MAJOR** | Breaking changes | `1.0.0` → `2.0.0` |

### Exemplos práticos

```markdown
## [2.0.0] - 2024-03-15

### Changed
- **BREAKING:** Renamed `getUser()` to `fetchUser()`
- **BREAKING:** API now requires authentication token

### Added
- New user profile page
- Support for custom themes

### Fixed
- Memory leak in data processing


## [1.5.0] - 2024-03-01

### Added
- Export reports to PDF
- Keyboard shortcuts for navigation

### Fixed
- Date picker not working on mobile


## [1.4.1] - 2024-02-15

### Fixed
- Critical bug in payment processing
- Typo in error messages
```

## Exemplo Completo de CHANGELOG.md

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- User preferences page
- Real-time notifications

### Changed
- Improved loading performance

## [2.1.0] - 2024-03-20

### Added
- Integration with Google Calendar
- Bulk export functionality
- Dark mode support

### Changed
- Redesigned dashboard with better UX
- Optimized database queries for faster loading

### Fixed
- Calendar not displaying events correctly
- Timezone issues in date picker

### Security
- Updated all dependencies to latest secure versions

## [2.0.0] - 2024-02-15

### Added
- Complete redesign of the user interface
- Mobile app support
- Two-factor authentication

### Changed
- **BREAKING:** API v2 now requires authentication for all endpoints
- **BREAKING:** Changed response format for `/users` endpoint
- Migrated from REST to GraphQL

### Removed
- **BREAKING:** Dropped support for API v1
- Legacy theme system

### Fixed
- Multiple security vulnerabilities
- Performance issues with large datasets

## [1.3.2] - 2024-01-30

### Fixed
- Critical bug in user authentication
- Memory leak in file upload

### Security
- Patched XSS vulnerability in comments

## [1.3.1] - 2024-01-15

### Fixed
- Login redirect not working
- Typos in documentation

## [1.3.0] - 2024-01-10

### Added
- User avatar upload
- Export to CSV

### Changed
- Improved search algorithm

## [1.2.0] - 2023-12-20

### Added
- Email notifications
- User preferences

### Fixed
- Date formatting issues

## [1.1.0] - 2023-12-01

### Added
- Initial release
- User authentication
- Basic CRUD operations

[Unreleased]: https://github.com/user/repo/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/user/repo/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/user/repo/compare/v1.3.2...v2.0.0
[1.3.2]: https://github.com/user/repo/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/user/repo/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/user/repo/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/user/repo/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/user/repo/releases/tag/v1.1.0
```

## Boas Práticas

### ✅ FAÇA

- Mantenha o changelog sempre atualizado
- Escreva para humanos, não para máquinas
- Agrupe mudanças por categoria
- Use datas no formato ISO (YYYY-MM-DD)
- Destaque breaking changes
- Link para issues/PRs quando relevante
- Mantenha uma seção `[Unreleased]` no topo

### ❌ NÃO FAÇA

- Copiar/colar mensagens de commit diretamente
- Incluir mudanças internas (refatorações que não afetam usuários)
- Usar jargão técnico excessivo
- Misturar categorias
- Esquecer de atualizar o changelog antes de release

## Como Atualizar o Changelog

### Durante o desenvolvimento

Adicione mudanças na seção `[Unreleased]`:

```markdown
## [Unreleased]

### Added
- User profile customization

### Fixed
- Login timeout issue
```

### Antes de uma release

1. Mova mudanças de `[Unreleased]` para nova versão
2. Adicione a data
3. Crie links de comparação

```markdown
## [Unreleased]

## [1.5.0] - 2024-03-20

### Added
- User profile customization

### Fixed
- Login timeout issue
```

## Automação com Conventional Commits

Se você segue [Conventional Commits](./commits.md), pode gerar changelogs automaticamente!

### Usando standard-version

```bash
# Instalação
npm install --save-dev standard-version

# Adicionar script no package.json
{
  "scripts": {
    "release": "standard-version"
  }
}

# Rodar release
npm run release

# Isso vai:
# 1. Atualizar version no package.json
# 2. Gerar/atualizar CHANGELOG.md
# 3. Criar commit e tag
```

### Usando conventional-changelog

```bash
# Instalação
npm install -g conventional-changelog-cli

# Gerar changelog
conventional-changelog -p angular -i CHANGELOG.md -s

# Gerar changelog completo (sobrescreve)
conventional-changelog -p angular -i CHANGELOG.md -s -r 0
```

## Template de Mudança

Ao adicionar uma mudança, use este formato:

```markdown
- [Descrição clara da mudança] (#issue ou !PR)
```

### Exemplos

```markdown
### Added
- Two-factor authentication for enhanced security (#234)
- Export dashboard to PDF format (!145)

### Fixed
- Resolve memory leak in image processing (#456)
- Correct timezone handling in date picker (!198)
```

## Changelog vs Release Notes

### Changelog
- Para **desenvolvedores** e **usuários técnicos**
- Mais detalhado
- Lista todas as mudanças notáveis

### Release Notes
- Para **usuários finais**
- Mais resumido e amigável
- Foca em features visíveis e benefícios

## Ferramentas

### GitHub Releases

Crie releases no GitHub com changelogs:

```bash
# Usando GitHub CLI
gh release create v1.2.0 --notes "$(cat CHANGELOG.md)"
```

### GitLab Auto DevOps

Configure para gerar changelogs automaticamente a partir de commits.

## Checklist de Release

Antes de publicar uma versão:

- [ ] Changelog atualizado com todas as mudanças
- [ ] Versão incrementada corretamente (MAJOR.MINOR.PATCH)
- [ ] Breaking changes claramente destacados
- [ ] Links de comparação atualizados
- [ ] Data da release adicionada
- [ ] Documentação atualizada
- [ ] Testes passando
- [ ] Tag criada no Git

## Recursos Adicionais

- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Standard Version](https://github.com/conventional-changelog/standard-version)
