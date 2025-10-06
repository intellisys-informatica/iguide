# Padrões JavaScript/TypeScript

Convenções e boas práticas para código JavaScript e TypeScript.

## Nomenclatura

### Variáveis e Funções

Use **camelCase** para variáveis e funções:

```javascript
// ✅ Bom
const userName = 'João';
const calculateTotal = () => {};

// ❌ Ruim
const user_name = 'João';
const CalculateTotal = () => {};
```

### Constantes

Use **UPPER_CASE** para constantes globais:

```javascript
// ✅ Bom
const API_URL = 'https://api.exemplo.com';
const MAX_RETRY_ATTEMPTS = 3;

// ❌ Ruim
const apiUrl = 'https://api.exemplo.com';
```

### Classes e Componentes

Use **PascalCase** para classes e componentes React:

```javascript
// ✅ Bom
class UserService {}
function UserProfile() {}

// ❌ Ruim
class userService {}
function userProfile() {}
```

### Arquivos

- Componentes: **PascalCase** - `UserProfile.tsx`
- Utilitários: **camelCase** - `formatDate.ts`
- Constantes: **camelCase** - `apiConfig.ts`

## Estrutura de Código

### Imports

Organize imports em grupos:

```typescript
// 1. External libraries
import React, { useState, useEffect } from 'react';
import { useRouter } from 'next/router';

// 2. Internal modules
import { UserService } from '@/services/UserService';
import { formatDate } from '@/utils/formatDate';

// 3. Components
import { Button } from '@/components/Button';
import { Card } from '@/components/Card';

// 4. Types
import type { User } from '@/types/User';

// 5. Styles
import styles from './UserProfile.module.css';
```

### Exports

Prefira **named exports** ao invés de default exports:

```typescript
// ✅ Bom
export const calculateTotal = () => {};
export const validateEmail = () => {};

// ❌ Evite (a não ser que seja componente principal)
export default calculateTotal;
```

## TypeScript

### Tipos vs Interfaces

**Use `type` para:**
- Tipos primitivos
- Unions
- Tuplas
- Tipos computados

```typescript
type ID = string | number;
type Coordinates = [number, number];
type Status = 'idle' | 'loading' | 'success' | 'error';
```

**Use `interface` para:**
- Objetos
- Classes
- Quando precisa de extensão

```typescript
interface User {
  id: string;
  name: string;
  email: string;
}

interface Admin extends User {
  permissions: string[];
}
```

### Evite `any`

```typescript
// ❌ Ruim
const processData = (data: any) => {};

// ✅ Bom
const processData = (data: unknown) => {
  if (typeof data === 'string') {
    // TypeScript agora sabe que data é string
  }
};

// ✅ Melhor ainda
interface ProcessData {
  id: string;
  value: number;
}
const processData = (data: ProcessData) => {};
```

### Use tipos específicos

```typescript
// ❌ Ruim
const handleClick = (event: any) => {};

// ✅ Bom
const handleClick = (event: React.MouseEvent<HTMLButtonElement>) => {};
```

## Funções

### Arrow Functions

Prefira arrow functions para callbacks e funções curtas:

```javascript
// ✅ Bom
const numbers = [1, 2, 3];
const doubled = numbers.map(n => n * 2);

// ✅ Também OK para funções nomeadas
const calculateTotal = (items) => {
  return items.reduce((sum, item) => sum + item.price, 0);
};
```

### Async/Await

Prefira `async/await` ao invés de `.then()`:

```javascript
// ❌ Ruim
function fetchUser(id) {
  return fetch(`/api/users/${id}`)
    .then(res => res.json())
    .then(data => data)
    .catch(err => console.error(err));
}

// ✅ Bom
async function fetchUser(id) {
  try {
    const response = await fetch(`/api/users/${id}`);
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Failed to fetch user:', error);
    throw error;
  }
}
```

### Parâmetros com Defaults

```javascript
// ✅ Bom
function createUser(name, role = 'user', active = true) {
  return { name, role, active };
}

// ✅ Com destructuring
function updateUser({ id, name, email = '' }) {
  // ...
}
```

## Objetos e Arrays

### Destructuring

```javascript
// ✅ Bom
const { name, email } = user;
const [first, second] = items;

// ✅ Com renomeação
const { name: userName } = user;

// ✅ Com defaults
const { role = 'user' } = user;
```

### Spread Operator

```javascript
// ✅ Bom - Copiar objeto
const updatedUser = { ...user, name: 'Novo Nome' };

// ✅ Bom - Merge objetos
const settings = { ...defaultSettings, ...userSettings };

// ✅ Bom - Copiar array
const newItems = [...items, newItem];
```

### Optional Chaining

```javascript
// ✅ Bom
const userName = user?.profile?.name;
const firstItem = items?.[0];
const result = fetchData?.();
```

### Nullish Coalescing

```javascript
// ✅ Bom
const displayName = user.name ?? 'Anônimo';

// ❌ Ruim (pode falhar com valores falsy válidos)
const displayName = user.name || 'Anônimo';
```

## Condicionais

### Guard Clauses

Retorne cedo para evitar aninhamento:

```javascript
// ❌ Ruim
function processUser(user) {
  if (user) {
    if (user.active) {
      if (user.email) {
        // lógica aqui
      }
    }
  }
}

// ✅ Bom
function processUser(user) {
  if (!user) return;
  if (!user.active) return;
  if (!user.email) return;

  // lógica aqui
}
```

### Ternários

Use para casos simples:

```javascript
// ✅ Bom
const message = isLoggedIn ? 'Bem-vindo' : 'Faça login';

// ❌ Ruim (muito complexo)
const value = condition1
  ? value1
  : condition2
    ? value2
    : condition3
      ? value3
      : defaultValue;

// ✅ Melhor
let value = defaultValue;
if (condition1) value = value1;
else if (condition2) value = value2;
else if (condition3) value = value3;
```

## Loops

### Métodos de Array

Prefira métodos funcionais:

```javascript
// ✅ Bom
const activeUsers = users.filter(u => u.active);
const userNames = users.map(u => u.name);
const total = prices.reduce((sum, price) => sum + price, 0);

// ❌ Evite for loops quando possível
const activeUsers = [];
for (let i = 0; i < users.length; i++) {
  if (users[i].active) {
    activeUsers.push(users[i]);
  }
}
```

### For...of para loops necessários

```javascript
// ✅ Bom
for (const user of users) {
  await processUser(user);
}

// ✅ Com index
for (const [index, user] of users.entries()) {
  console.log(index, user);
}
```

## Tratamento de Erros

### Try/Catch

```javascript
// ✅ Bom
async function saveUser(userData) {
  try {
    const response = await api.post('/users', userData);
    return response.data;
  } catch (error) {
    if (error.response?.status === 409) {
      throw new Error('User already exists');
    }
    console.error('Failed to save user:', error);
    throw error;
  }
}
```

### Custom Errors

```typescript
// ✅ Bom
class ValidationError extends Error {
  constructor(message: string, public field: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

throw new ValidationError('Invalid email', 'email');
```

## Comentários

### JSDoc

```javascript
/**
 * Calcula o total do carrinho aplicando descontos
 * @param {Array<CartItem>} items - Itens do carrinho
 * @param {number} discountPercentage - Percentual de desconto (0-100)
 * @returns {number} Total calculado com desconto
 * @throws {Error} Se items não for um array
 * @example
 * calculateTotal([{price: 100}], 10) // 90
 */
function calculateTotal(items, discountPercentage) {
  // implementação
}
```

### Comentários Inline

```javascript
// ✅ Bom - Explica o "porquê"
// Usando setTimeout para evitar race condition com o debounce
setTimeout(() => search(query), 300);

// ❌ Ruim - Explica o "o que" (óbvio pelo código)
// Incrementa contador
counter++;
```

## React Específico

### Hooks

```typescript
// ✅ Bom - Ordem consistente
function UserProfile({ userId }: Props) {
  // 1. Hooks de estado
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(false);

  // 2. Hooks de contexto
  const { theme } = useTheme();

  // 3. Hooks customizados
  const { data } = useFetchUser(userId);

  // 4. useEffect
  useEffect(() => {
    // ...
  }, [userId]);

  // 5. Handlers
  const handleClick = () => {};

  // 6. Render
  return <div>...</div>;
}
```

### Props

```typescript
// ✅ Bom
interface ButtonProps {
  children: React.ReactNode;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export const Button: React.FC<ButtonProps> = ({
  children,
  onClick,
  variant = 'primary',
  disabled = false,
}) => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  );
};
```

## Performance

### Memoização

```typescript
// ✅ Bom - Memoizar valores computados pesados
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data);
}, [data]);

// ✅ Bom - Memoizar callbacks
const handleClick = useCallback(() => {
  doSomething(id);
}, [id]);

// ❌ Ruim - Memoizar tudo desnecessariamente
const sum = useMemo(() => a + b, [a, b]); // Muito simples
```

### Code Splitting

```javascript
// ✅ Bom
const HeavyComponent = lazy(() => import('./HeavyComponent'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <HeavyComponent />
    </Suspense>
  );
}
```

## Checklist de Code Review

- [ ] Código segue padrões de nomenclatura
- [ ] Imports organizados corretamente
- [ ] TypeScript sem `any`
- [ ] Tratamento de erros adequado
- [ ] Não há código duplicado
- [ ] Funções são pequenas e focadas
- [ ] Variáveis têm nomes descritivos
- [ ] Comentários explicam o "porquê"
- [ ] Testes foram adicionados/atualizados

## Recursos Adicionais

- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
