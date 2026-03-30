# Agenda/Diário

App Flutter com duas funcionalidades: **calculadora** e **diário pessoal**, construído com Clean Architecture e Material Design 3.

## Funcionalidades

- **Calculadora** — operações básicas (+, −, ×, ÷), decimais, backspace, divisão por zero tratada
- **Diário** — criar, visualizar e excluir entradas com persistência local (SQLite)
- Navegação por abas preservando estado
- Tema escuro

## Tecnologias

| Pacote | Uso |
|--------|-----|
| `flutter` 3.x | Framework |
| `sqflite ^2.3.0` | Persistência local SQLite |
| `provider ^6.1.2` | State management + DI |
| `intl ^0.19.0` | Formatação de datas em pt-BR |
| `path ^1.9.0` | Caminhos para o banco SQLite |

## Arquitetura

Clean Architecture por feature — `domain` / `data` / `presentation`:

```
lib/
├── main.dart                  # DI com MultiProvider
├── app.dart                   # MaterialApp + navegação
├── core/error/                # Failures
├── shared/                    # Theme + widgets reutilizáveis
└── features/
    ├── calculator/
    │   ├── data/              # Lógica pura da calculadora
    │   └── presentation/      # Controller + Page + Widgets
    └── diary/
        ├── domain/            # Entities, Repository (abstract), UseCases
        ├── data/              # Model, Datasource (sqflite), RepositoryImpl
        └── presentation/      # Controller, Pages, Widgets
```

## Como rodar

**Pré-requisito:** Flutter 3.x instalado ([flutter.dev](https://flutter.dev))

```bash
git clone https://github.com/efemoreira/agenda-diario.git
cd agenda-diario
flutter pub get
flutter run
```

> Compatível com emulador Android e iOS.
