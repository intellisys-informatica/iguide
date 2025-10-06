# Arquitetura de Software

Padrões arquiteturais recomendados para organização de código.

## Princípios SOLID

### S - Single Responsibility

Cada classe/módulo deve ter apenas uma responsabilidade.

```typescript
// ❌ Ruim
class UserManager {
  saveUser() {}
  sendEmail() {}
  generateReport() {}
}

// ✅ Bom
class UserRepository {
  saveUser() {}
}

class EmailService {
  sendEmail() {}
}

class ReportGenerator {
  generateReport() {}
}
```

### O - Open/Closed

Aberto para extensão, fechado para modificação.

```typescript
// ✅ Bom
interface PaymentMethod {
  process(amount: number): void;
}

class CreditCardPayment implements PaymentMethod {
  process(amount: number) { /* ... */ }
}

class PayPalPayment implements PaymentMethod {
  process(amount: number) { /* ... */ }
}
```

### L - Liskov Substitution

Subclasses devem ser substituíveis por suas classes base.

### I - Interface Segregation

Prefira interfaces específicas a uma interface geral.

```typescript
// ✅ Bom
interface Readable {
  read(): string;
}

interface Writable {
  write(data: string): void;
}

class File implements Readable, Writable {
  read() { /* ... */ }
  write(data: string) { /* ... */ }
}
```

### D - Dependency Inversion

Dependa de abstrações, não de implementações concretas.

```typescript
// ✅ Bom
interface Database {
  save(data: any): void;
}

class UserService {
  constructor(private db: Database) {}

  saveUser(user: User) {
    this.db.save(user);
  }
}
```

## Camadas da Aplicação

### Arquitetura em 3 camadas

```
Presentation Layer (UI)
    ↓
Business Logic Layer (Services)
    ↓
Data Access Layer (Repositories)
```

### Exemplo Prático

```typescript
// Data Layer
class UserRepository {
  async findById(id: string): Promise<User> {
    return db.users.findOne({ id });
  }
}

// Business Logic Layer
class UserService {
  constructor(private userRepo: UserRepository) {}

  async getUser(id: string): Promise<UserDTO> {
    const user = await this.userRepo.findById(id);
    return this.toDTO(user);
  }
}

// Presentation Layer
function UserProfile({ userId }: Props) {
  const userService = new UserService(new UserRepository());
  const user = await userService.getUser(userId);

  return <div>{user.name}</div>;
}
```

## Design Patterns

### Repository Pattern

```typescript
interface Repository<T> {
  findById(id: string): Promise<T>;
  findAll(): Promise<T[]>;
  create(data: T): Promise<T>;
  update(id: string, data: Partial<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

class UserRepository implements Repository<User> {
  async findById(id: string): Promise<User> { /* ... */ }
  async findAll(): Promise<User[]> { /* ... */ }
  // ...
}
```

### Factory Pattern

```typescript
class UserFactory {
  static create(type: 'admin' | 'user'): User {
    if (type === 'admin') {
      return new Admin();
    }
    return new RegularUser();
  }
}
```

### Observer Pattern

```typescript
class EventEmitter {
  private events: Map<string, Function[]> = new Map();

  on(event: string, callback: Function) {
    if (!this.events.has(event)) {
      this.events.set(event, []);
    }
    this.events.get(event)!.push(callback);
  }

  emit(event: string, data: any) {
    this.events.get(event)?.forEach(cb => cb(data));
  }
}
```

## Clean Architecture

```
Entities (Business Rules)
    ↓
Use Cases (Application Logic)
    ↓
Interface Adapters (Controllers, Presenters)
    ↓
Frameworks & Drivers (UI, DB, External APIs)
```

## Boas Práticas

- ✅ Separação de responsabilidades
- ✅ Injeção de dependências
- ✅ Testes unitários em cada camada
- ✅ Código desacoplado e reutilizável
- ❌ Lógica de negócio na UI
- ❌ Acesso direto ao banco na UI

## Recursos Adicionais

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [SOLID Principles](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)
- [Design Patterns](https://refactoring.guru/design-patterns)
