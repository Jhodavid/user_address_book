# User Address Book

App Flutter para **gestionar usuarios y direcciones** con almacenamiento local, ruteo declarativo y una UI simple inspirada en formularios modernos.

- **Arquitecturas**:
   - **Clean Architecture** a nivel de proyecto (Domain / Infrastructure / UI).
   - **MVP** (Model–View–Presenter) en la capa de UI.
- **Tecnologías principales**: **Riverpod**, **GoRouter**, **Hive (hive_flutter)**, **Intl / gen-l10n**.

---

## Tabla de contenido
1. [Características](#características)
2. [Arquitecturas](#arquitecturas)
   - [Clean Architecture](#clean-architecture)
   - [MVP en la UI](#mvp-en-la-ui)
3. [Principios SOLID (evidencias)](#principios-solid-evidencias)
4. [Tecnologías principales](#tecnologías-principales)
5. [Estructura de carpetas](#estructura-de-carpetas)
6. [Flujo principal](#flujo-principal)
7. [Providers (Riverpod)](#providers-riverpod)
8. [Persistencia (Hive)](#persistencia-hive)
9. [Ruteo (GoRouter)](#ruteo-gorouter)
10. [i18n (gen-l10n/Intl)](#i18n-gen-l10nintl)
11. [Estilo de UI](#estilo-de-ui)
12. [Ejecución y configuración](#ejecución-y-configuración)
13. [Pruebas](#pruebas)

---

## Características
- Crear usuarios con **nombre**, **apellido** y **fecha de nacimiento** (selector modal sencillo).
- Gestión de **direcciones** por usuario (BottomSheet), con opción para marcar **principal**.
- **Listado global** de usuarios siempre sincronizado tras crear/editar/borrar.
- **Detalle** de un usuario con todas sus direcciones.
- Errores en **modal** con botón “Aceptar”.
- **Loading** de pantalla completa controlable desde cualquier `BuildContext`.

---

## Arquitecturas

### Clean Architecture
Separación por capas y dependencias dirigidas hacia el **dominio**:

- **Domain**
   - `entities/`: entidades puras (`User`, `Address`).
   - `gateway/`: *ports* (interfaces) del dominio (p. ej. `UserRepository`).
   - `use_cases/`: orquestan reglas de negocio (crear usuario, agregar dirección, etc.).
   - `models/`: tipos auxiliares del dominio (si aplica).

- **Infrastructure**
   - `datasources/`: acceso a datos (Hive).
   - `mappers/`: conversión `Map ⇄ Entity` (mantiene limpio el dominio).
   - `driven_adapters/`: implementaciones concretas de `gateway` (p. ej., `HiveUserAdapter`).

- **UI**
   - `screens/feature/presenter/`: Presenters de pantalla (estado y validación).
   - `screens/feature/model/`: modelos de estado de la vista.
   - `screens/feature/widgets/`: Views y componentes.

### MVP en la UI
- **View**: Widgets/pantallas (sin lógica de negocio; muestran estado y disparan eventos).
- **Presenter**: Maneja estado y validaciones; llama a los casos de uso a través de providers.
- **Model (UI State)**: Estado inmutable para la vista (ej. `UserFormState`, `AddressFormState`).

Beneficios: testabilidad, vistas delgadas, responsabilidades claras y fácil mantenimiento.

---

## Principios SOLID (evidencias)

- **S — Single Responsibility**
   - *Presenters*: estado/validación por pantalla (`ui/screens/.../presenter/`).
   - *Mappers*: sólo conversión `Map ⇄ Entity` (`infrastructure/mappers/`).
   - *Adapters*: sólo creación y acceso a datos (`infrastructure/driven_adapters/`).

- **O — Open/Closed**
   - Implementación de *adapters* (p. ej., `HiveUserAdapter`) o cambios de estructura en almacenamiento se agregan **sin modificar** el dominio ni la UI (extensión por mappers/adapters).

- **L — Liskov Substitution**
   - Cualquier implementación de `UserRepository` (Hive, mock) sustituye a otra sin romper casos de uso ni UI (la UI depende del **port**, no del detalle).

- **I — Interface Segregation**
   - *Gateway* específicos por agregado evitan interfaces extensas y reducen dependencias innecesarias.

- **D — Dependency Inversion**
   - El dominio depende de **abstracciones**; la infraestructura depende del dominio (y no al revés). La composición se hace con **providers**.

---

## Tecnologías principales
- **Riverpod** y `@riverpod` (codegen) para **estado** y **inyección de dependencias**.
- **GoRouter** para **rutas declarativas** (`/list`, `/form`).
- **Hive + hive_flutter** para **persistencia local** (cajas/boxes) usando `Map` y *mappers*.
- **Intl / gen-l10n** para **localización** (ES/EN).
- **uuid** para generación de IDs.
- **flutter_test + mocktail** para pruebas unitarias (opcional).

---

## Estructura de carpetas

> Resumen del árbol.

```text
lib/
├─ config/
│  ├─ constants/
│  │  └─ constants.dart
│  ├─ locale/
│  │  ├─ app_localizations.dart
│  │  ├─ app_localizations_en.dart
│  │  └─ app_localizations_es.dart
│  └─ providers/
│     ├─ models/
│     └─ providers.dart
├─ domain/
│  ├─ entities/
│  ├─ gateway/
│  ├─ models/
│  ├─ use_cases/
│  └─ domain.dart
├─ infrastructure/
│  ├─ constants/
│  ├─ datasources/
│  ├─ driven_adapters/
│  ├─ mappers/
│  └─ infrastructure.dart
├─ ui/
│  ├─ common/
│  │  ├─ constants/
│  │  ├─ helpers/
│  │  └─ widgets/
│  ├─ screens/
│  │  ├─ user_form/
│  │  │  ├─ interface/
│  │  │  ├─ model/
│  │  │  ├─ presenter/
│  │  │  ├─ widgets/
│  │  │  │  └─ address_form/
│  │  │  ├─ widgets/address_data_card.dart
│  │  │  ├─ widgets/birthdate_picker.dart
│  │  │  └─ user_form.dart
│  │  └─ user_list/
│  │     └─ widgets/
│  │        └─ user_list.dart
│  ├─ app.dart
│  └─ ui.dart
└─ main.dart
```

## Flujo principal

### UserForm
- La vista captura **firstName**, **lastName**, **birthDate** (modal con `CupertinoDatePicker`) y **direcciones** en **BottomSheet**.
- El **Presenter** valida y llama a los **casos de uso** (vía providers).
- Si todo va bien, se navega a **`/users`** y el **listado global de usuarios** se actualiza automáticamente.

### UserList
- Consume `List<User> users` desde el **provider global (appScopeProvider)** del listado.
- Muestra direcciones, permite **agregar** y **marcar principal**.

### UserDetail
- Carga por `userId` y muestra todas las direcciones del usuario.

---

## Providers (Riverpod)

- **Use cases** (`UserUseCases`): instancia única de la clase de casos de uso con el **repositorio (adapter)** inyectado mediante `appScopeProvider`.
- **AppScope** (`appScopeProvider`): Provider global que centraliza **mutaciones** (`listUsers/create/update/delete`) y **actualiza** el estado local con `_refreshUsers` automáticamente.
- **Presenters** con `@riverpod` para cada pantalla (p. ej., `UserFormPresenter`, `AddressFormPresenter`).

**Codegen**
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Persistencia (Hive)

Inicialización (ejemplo en main.dart):

```
await Hive.initFlutter();
await Hive.openBox<Map>('users');
```

- Se guardan Maps (y no clases) para aprovechar el uso de Mappers.
- Mappers en infrastructure/mappers traducen Entity ⇄ Map.
- Driven Adapter (ej. HiveUserAdapter) implementa UserRepository y delega en el DataSource Hive.

## Ruteo (GoRouter)

Rutas típicas
- `/list` — Listado de usuarios
- `/form` — Creación de usuarios

Se monta con:

```
MaterialApp.router(
  routerConfig: ... // ver config/router/app_router.dart
)
```

## i18n (gen-l10n/Intl)

- Archivos generados en lib/config/locale/ (app_localizations_*.dart).
- Configurar supportedLocales y localizationsDelegates en MaterialApp.router.
- Los textos de validación/errores pueden mapearse a claves de i18n.

## Estilo de UI

- Color primario (botones): 0xff5f72ea.
- Fondo débil (inputs/tarjetas): 0xffdce6fa.
- Formulario de fecha en modal (selector Cupertino sencillo).
- BottomSheet para crear direcciones.
- Modal de error con botón “Aceptar”.
- Loading de pantalla completa controlable por context con métodos show/hide.

## Ejecución y configuración

### Requisitos
Se trabaja con.
- Flutter 3.35.0 / Dart  3.9.0

### Obtener dependencias y generar código

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
````

# o en modo watch:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Ejecutar
```bash
flutter run
```

### Pruebas

```bash
flutter test
```

# cobertura opcional

```bash
flutter test --coverage
flutter test --coverage && genhtml coverage/lcov.info --output=coverage && open coverage/index.html
```