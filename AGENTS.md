# Panduan Agent - Ecommerce Flutter App

## Perintah Build/Lint/Test
- **Build**: `flutter build apk` (Android) atau `flutter build ios` (iOS)
- **Lint**: `flutter analyze` (menggunakan flutter_lints dari analysis_options.yaml)
- **Test semua**: `flutter test`
- **Test single file**: `flutter test test/nama_test.dart`
- **Run app**: `flutter run`

## Arsitektur Codebase
Struktur **Feature-First Architecture** dengan clean architecture:
- `lib/core/` - Komponen shared (router, themes, shared_widgets)
- `lib/features/{feature}/` - Setiap feature punya 3 layer: `data/`, `domain/`, `presentation/`
- Features: auth, home, shop, cart, checkout, profile
- Routing menggunakan **go_router** v17.0.1 dengan definisi route di `lib/core/router/app_router.dart`
- Base navigation: `BasePage` (bottom navigation dengan GoogleNavBar)

## Konvensi Kode
- **Styling**: Google Fonts (Poppins), Material Design, colors dari `AppPallete`
- **Widget naming**: `{nama}_page.dart` untuk halaman, `{nama}_widget.dart` untuk komponen reusable
- **Route naming**: `static const routeName` dan `routePath` di setiap page
- **State management**: StatefulWidget dengan local state (belum pakai BLOC/Riverpod)
- **Models**: Definisikan model classes di dalam file widget jika hanya digunakan lokal
- **Constants**: Gunakan `const` untuk widget yang tidak berubah
- **Comments**: DartDoc untuk widget publik (`///`), komentar inline minimal
- **Imports**: Urutannya: package dependencies, internal imports (core, features)
- **Error handling**: Gunakan `debugPrint()` untuk logging development
- **Assets**: Icons di `assets/icons/`, daftarkan di pubspec.yaml

## Dependencies Utama
- `go_router: ^17.0.1` - Routing
- `google_fonts: ^7.0.1` - Typography
- `google_nav_bar: ^5.0.7` - Bottom navigation
- `flutter_lints: ^5.0.0` - Linting rules

## Issue Tracking dengan Beads
Project menggunakan **Beads** (AI-native issue tracking) untuk manajemen task:
- **Database**: `.beads/beads.db` (SQLite) + `.beads/issues.jsonl` (export)
- **Commands**:
  - `bd create "isu title"` - Buat issue baru
  - `bd list` - Lihat semua issues
  - `bd show <issue-id>` - Detail issue
  - `bd update <id> --status in_progress/done` - Update status
  - `bd sync` - Sync dengan git (export ke JSONL)
- **Konfigurasi**: `.beads/config.yaml` untuk settings Beads
- **Integration**: Beads sync otomatis saat commit via `bd sync`

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
