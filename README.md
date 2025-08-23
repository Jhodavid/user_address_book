# 🏠 User Address Book

Gestión de usuarios y direcciones con persistencia local usando Hive, Riverpod y Flutter.

---

## 🚀 Tecnologías y Herramientas

- **Flutter**: UI moderna y multiplataforma
- **Dart**: Lenguaje principal
- **Riverpod**: Gestión de estado reactiva
- **Hive**: Base de datos local rápida y ligera
- **mocktail**: Mocking para tests
- **flutter_test**: Framework de testing

---

## 📁 Estructura de Carpetas
```
user_address/
├─ lib/
│  ├─ config/
│  │  ├─ constants/
│  │  │  └─ constants.dart
│  │  ├─ locale/
│  │  │  ├─ app_localizations.dart
│  │  │  ├─ app_localizations_en.dart
│  │  │  └─ app_localizations_es.dart
│  │  └─ providers/
│  │     ├─ models/
│  │     └─ providers.dart
│  ├─ domain/
│  │  ├─ entities/
│  │  ├─ gateway/
│  │  ├─ models/
│  │  ├─ use_cases/
│  │  └─ domain.dart
│  ├─ infrastructure/
│  │  ├─ constants/
│  │  ├─ datasources/
│  │  ├─ driven_adapters/
│  │  ├─ mappers/
│  │  └─ infrastructure.dart
│  ├─ ui/
│  │  ├─ common/
│  │  │  ├─ constants/
│  │  │  ├─ helpers/
│  │  │  └─ widgets/
│  │  ├─ screens/
│  │  │  ├─ user_form/
│  │  │  │  ├─ interface/
│  │  │  │  ├─ model/
│  │  │  │  ├─ presenter/
│  │  │  │  ├─ widgets/
│  │  │  │  │  └─ address_form/
│  │  │  │  ├─ widgets/address_data_card.dart
│  │  │  │  ├─ widgets/birthdate_picker.dart
│  │  │  │  └─ user_form.dart
│  │  │  └─ user_list/
│  │  │     └─ widgets/
│  │  │        └─ user_list.dart
│  │  ├─ app.dart
│  │  └─ ui.dart
│  └─ main.dart
├─ test/
├─ web/
```

---

## 🧩 Principales Componentes

- **UserLocalDS**: DataSource para usuarios usando Hive
- **HiveInit**: Inicialización y configuración de Hive
- **Tests unitarios**: Cobertura de lógica y persistencia

---

## 🛠️ Instalación y Ejecución

1. Clona el repositorio  
   `git clone https://github.com/Jhodavid/user_address_book`

2. Instala dependencias  
   `flutter pub get`

3. Ejecuta la app  
   `flutter run`

4. Corre los tests  
   `flutter test`

5. Corre los tests con cobertura y genera reporte
   `flutter test --coverage && genhtml coverage/lcov.info --output=coverage && open coverage/index.html`

---

## 📦 Scripts Útiles

- `flutter pub get` — Instala dependencias
- `flutter run` — Ejecuta la app
- `flutter test` — Ejecuta los tests