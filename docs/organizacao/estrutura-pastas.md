# Estrutura de Pastas

Guia de organização de diretórios para projetos.

## Estrutura Básica

```
project/
├── src/
│   ├── components/
│   ├── pages/
│   ├── services/
│   ├── utils/
│   ├── types/
│   ├── hooks/
│   ├── context/
│   ├── styles/
│   └── assets/
├── public/
├── tests/
├── docs/
└── config/
```

## Detalhamento

### src/components

Componentes reutilizáveis:

```
components/
├── Button/
│   ├── Button.tsx
│   ├── Button.module.css
│   ├── Button.test.tsx
│   └── index.ts
├── Card/
└── Modal/
```

### src/pages

Páginas da aplicação:

```
pages/
├── Home/
│   ├── Home.tsx
│   ├── Home.module.css
│   └── index.ts
├── Profile/
└── Settings/
```

### src/services

Integração com APIs e serviços externos:

```
services/
├── api/
│   ├── client.ts
│   ├── users.ts
│   └── products.ts
├── auth/
│   └── authService.ts
└── storage/
    └── localStorage.ts
```

### src/utils

Funções utilitárias:

```
utils/
├── formatDate.ts
├── validateEmail.ts
├── formatCurrency.ts
└── constants.ts
```

### src/types

Definições de tipos TypeScript:

```
types/
├── User.ts
├── Product.ts
├── ApiResponse.ts
└── index.ts
```

### src/hooks

Custom hooks do React:

```
hooks/
├── useAuth.ts
├── useFetch.ts
├── useLocalStorage.ts
└── index.ts
```

### src/context

Context API do React:

```
context/
├── AuthContext.tsx
├── ThemeContext.tsx
└── index.ts
```

## Feature-Based (Alternativa)

Para projetos grandes:

```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── services/
│   │   ├── types/
│   │   └── pages/
│   ├── products/
│   └── users/
├── shared/
│   ├── components/
│   ├── hooks/
│   ├── utils/
│   └── types/
└── app/
```

## Boas Práticas

- ✅ Agrupe arquivos relacionados
- ✅ Use index.ts para exports limpos
- ✅ Mantenha hierarquia de no máximo 3-4 níveis
- ✅ Componentes com própria pasta quando têm testes/estilos
- ❌ Evite pastas muito genéricas ("misc", "other")
- ❌ Não misture lógica de features diferentes

## Recursos Adicionais

- [React Folder Structure](https://www.robinwieruch.de/react-folder-structure/)
- [Project Structure Best Practices](https://github.com/goldbergyoni/nodebestpractices#1-project-structure-practices)
