# Nomenclatura

Convenções de nomenclatura para arquivos, variáveis, funções e outros elementos do código.

## Arquivos e Pastas

### Componentes React

```
PascalCase
UserProfile.tsx
ShoppingCart.tsx
ButtonGroup.tsx
```

### Utilitários e Helpers

```
camelCase
formatDate.ts
validateEmail.ts
apiClient.ts
```

### CSS/SCSS

```
kebab-case
button-group.scss
user-profile.module.css
```

### Testes

```
Nome do arquivo + .test ou .spec
UserProfile.test.tsx
formatDate.spec.ts
```

## Variáveis

### JavaScript/TypeScript

```typescript
// camelCase para variáveis e funções
const userName = 'João';
const isActive = true;
const calculateTotal = () => {};

// PascalCase para classes e componentes
class UserService {}
const UserProfile = () => {};

// UPPER_CASE para constantes
const API_URL = 'https://api.example.com';
const MAX_RETRIES = 3;
```

### Booleanos

Prefixos: `is`, `has`, `should`, `can`

```typescript
const isLoading = true;
const hasPermission = false;
const shouldUpdate = true;
const canEdit = false;
```

### Arrays

Sempre plural:

```typescript
const users = [];
const items = [];
const products = [];
```

### Funções

Verbos + substantivo:

```typescript
getUserById();
createNewUser();
updateUserProfile();
deleteOldRecords();
validateEmail();
```

## CSS Classes

### BEM

```css
.block {}
.block__element {}
.block--modifier {}

/* Exemplos */
.card {}
.card__title {}
.card__body {}
.card--featured {}
```

### Estados

```css
.is-active {}
.is-disabled {}
.is-loading {}
.has-error {}
```

## Banco de Dados

### Tabelas

```
snake_case, plural
users
user_profiles
shopping_carts
```

### Colunas

```
snake_case, singular
id
user_name
created_at
is_active
```

## Git

### Branches

```
feature/add-user-authentication
bugfix/fix-login-redirect
hotfix/patch-security-issue
release/v1.2.0
```

### Commits

```
feat: add user authentication
fix: resolve login redirect issue
docs: update README
```

## Checklist

- [ ] Nomes descritivos e claros
- [ ] Consistência em todo o projeto
- [ ] Evitar abreviações (exceto convencionais)
- [ ] Idioma consistente (inglês recomendado)
- [ ] Case apropriado para o contexto
