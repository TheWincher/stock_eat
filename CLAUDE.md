# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter mobile app for managing food stock at home (tracking products, quantities, storage
location, and expiration dates). Currently in early scaffolding — the codebase is still close to
the default `flutter create` template; the architecture below is the agreed target structure being
built out incrementally, not yet fully implemented.

## Commands

- `flutter pub get` — install dependencies
- `flutter run` — run the app (targets the connected device/emulator, e.g. Genymotion)
- `flutter analyze` — static analysis (lints from `package:flutter_lints/flutter.yaml`, see
  `analysis_options.yaml`)
- `flutter test` — run all tests
- `flutter test test/widget_test.dart` — run a single test file
- `dart run build_runner build --delete-conflicting-outputs` — generate code (Drift tables,
  Freezed entities) once those packages are added; required after editing any `*.dart` file
  annotated for codegen

## Architecture

Clean Architecture with four layers under `lib/`, dependency direction always pointing inward
(`presentation` → `application` → `domain` ← `infrastructure`). `domain` must never import from
the other three layers.

- **`domain/`** — pure Dart, no Flutter/package dependencies beyond value objects. Contains
  entities (`entities/`) and abstract repository interfaces (`repositories/`) that the outer
  layers implement/consume. This is the only layer allowed to define business rules.
- **`application/`** — use cases (`usecases/`), one file per business action, orchestrating domain
  entities and repository interfaces. No direct knowledge of Drift, Riverpod widgets, or UI.
- **`infrastructure/`** — concrete implementations of the domain repository interfaces
  (`repositories/`), the Drift database and table definitions (`database/`, `database/tables/`),
  and mappers converting between DB rows and domain entities (`mappers/`).
- **`presentation/`** — Flutter UI: pages, widgets, and Riverpod providers/controllers
  (`providers/`) that call into `application` use cases. State management is Riverpod
  (`flutter_riverpod`).
- **`core/`** — cross-cutting concerns not specific to one layer (e.g. `error/` for domain
  failures/exceptions).

### Tech stack decisions

- **State management**: Riverpod.
- **Persistence**: Drift (SQLite) — chosen over Isar/Hive for the relational shape of the data
  (products/categories/stock items with foreign-key-style relations) and reactive query streams.
- **Domain entities**: immutable, built with `freezed` (gives `copyWith`/equality for free; reuses
  the `build_runner` toolchain already needed for Drift).

### Domain model (MVP scope)

Minimal entity set, deliberately excluding user-configurable units/locations and stock movement
history for now:

- `Category`: `id`, `name`
- `Product`: `id`, `name`, `categoryId`, `defaultUnit`, `barcode?`
- `StockItem`: `id`, `productId`, `quantity`, `unit`, `location`, `expirationDate?`, `addedAt`
- `Unit` (enum): `piece, gram, kilogram, milliliter, liter`
- `StorageLocation` (enum): `fridge, freezer, pantry, other`

`StockItem.expirationDate` is intentionally a single date for the MVP (no DLC/DDM distinction yet
— see conversation history if that needs revisiting).
