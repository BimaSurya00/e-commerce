# E-Commerce Flutter App

Aplikasi e-commerce modern yang dibangun dengan Flutter, menggunakan arsitektur Feature-First dengan clean architecture. Aplikasi ini menyediakan pengalaman belanja online yang lengkap dengan fitur authentication, product catalog, shopping cart, dan checkout.

## 🚀 Fitur Utama

### 🏠 Home Page
- **Personalized Welcome** - Sapaan pengguna dengan header interaktif
- **Smart Search** - Search bar dengan filter products
- **Promo Carousel** - Auto-sliding banner untuk promosi dan penawaran spesial
- **Category Filter** - Filter produk berdasarkan kategori (All, Men, Women, Kids, Accessories, Shoes)
- **Featured Products** - Grid produk unggulan dengan rating, review count, dan badge (SALE/NEW)
- **Add to Cart** - Quick add to cart dengan notifikasi SnackBar
- **Favorite System** - Toggle favorite untuk produk

### 🛍️ Shop & Product Details
- **Product Catalog** - Daftar produk dengan grid layout yang responsif
- **Detail Produk Lengkap**:
  - Image carousel dengan preview
  - Product title dan harga (dengan original price untuk diskon)
  - Color selection (pilihan warna produk)
  - Size selection (pilihan ukuran dengan stok)
  - Quantity selector
  - Product description
  - Reviews section dengan rating dan komentar
- **Product Actions**:
  - Add to Cart
  - Buy Now
  - Toggle Favorite
  - Share product

### 🛒 Shopping Cart
- **Cart Item Management**:
  - Item cards dengan image, title, price, quantity
  - Quantity control (increase/decrease)
  - Remove items
- **Promo Code Input** - Input field untuk kode promo
- **Cart Summary**:
  - Subtotal calculation
  - Shipping cost
  - Tax calculation
  - Discount display
  - Total amount
- **Empty State** - Beautiful empty state dengan call-to-action
- **Checkout Button** - Navigate ke checkout page

### 💳 Checkout
- **Shipping Address**:
  - Address form dengan validation
  - Multiple saved addresses
  - Set default address
- **Shipping Methods**:
  - Standard shipping
  - Express shipping
  - Same-day delivery (dengan harga berbeda)
- **Payment Methods**:
  - Credit/Debit Card
  - Digital wallets (GoPay, OVO, Dana)
  - Bank transfer
  - COD (Cash on Delivery)
- **Order Review**:
  - Item list summary
  - Shipping details
  - Payment confirmation
  - Place Order button

### 👤 Authentication
- **Login Page**:
  - Email/password input
  - Remember me checkbox
  - Forgot password link
  - Sign up link
- **Register Page**:
  - Full registration form (name, email, password)
  - Terms & conditions checkbox
  - Link to login page

### 👤 Profile
- User profile page (under development)

## 🏗️ Arsitektur

### Feature-First Architecture
Project menggunakan struktur **Feature-First** dengan clean architecture:

```
lib/
├── core/                      # Shared components
│   ├── router/               # Routing configuration (go_router)
│   ├── themes/               # App themes & colors (AppPallete)
│   └── shared_widgets/       # Reusable widgets
├── features/                 # Feature modules
│   ├── auth/                # Authentication (login, register)
│   ├── home/                # Home page with promos & featured products
│   ├── shop/                # Product catalog & detail pages
│   ├── cart/                # Shopping cart functionality
│   ├── checkout/            # Checkout process
│   ├── profile/             # User profile
│   └── base/                # Base navigation page
└── main.dart               # App entry point
```

### Clean Architecture Layers
Setiap feature memiliki 3 layer:
- **data/** - Data sources, repositories, models
- **domain/** - Business logic, use cases, entities
- **presentation/** - UI components (pages, widgets)

## 🎨 Desain & Styling

### Design System
- **Typography**: Google Fonts (Poppins)
- **Color Palette**: Custom colors dari `AppPallete`
  - Primary: `#4D2FB2` (Ungu gelap)
  - Secondary: `#B153D7` (Ungu terang)
  - Background: `#F375C2` (Pink)
  - Accent: `#0E21A0` (Biru tua)
- **Icons**: Material Icons + Custom icons di `assets/icons/`

### UI Components
- **Bottom Navigation**: GoogleNavBar dengan 4 tabs (Home, Shop, Cart, Profile)
- **Promo Carousel**: Auto-sliding carousel dengan page indicators
- **Product Grid**: Responsive grid dengan 2 columns
- **Forms**: Material Design form dengan proper validation

## 🛠️ Tech Stack

### Dependencies
- **Flutter SDK**: ^3.9.2
- **go_router**: ^17.0.1 - Declarative routing
- **google_fonts**: ^7.0.1 - Typography
- **google_nav_bar**: ^5.0.7 - Bottom navigation
- **cupertino_icons**: ^1.0.8 - iOS-style icons

### Dev Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: ^5.0.0 - Linting rules

## 📦 Installation

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK compatible with Flutter
- Android Studio / VS Code
- Android/iOS emulator or device

### Setup
1. Clone repository:
```bash
git clone https://github.com/BimaSurya00/e-commerce.git
cd e-commerce
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## 🧪 Testing & Quality

### Run Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Code Analysis
```bash
# Analyze code for issues
flutter analyze

# Format code
dart format .
```

### Build
```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

## 📋 Issue Tracking

Project menggunakan **Beads** untuk AI-native issue tracking:

### Beads Commands
```bash
# Create new issue
bd create "Add user authentication"

# List all issues
bd list

# Show issue details
bd show <issue-id>

# Update issue status
bd update <issue-id> --status in_progress
bd update <issue-id> --status done

# Sync with git
bd sync
```

### Beads Files
- Database: `.beads/beads.db` (SQLite)
- Export: `.beads/issues.jsonl`
- Config: `.beads/config.yaml`

## 🤝 Kontribusi

1. Fork repository
2. Buat feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'feat: add amazing feature'`)
4. Sync Beads (`bd sync`)
5. Push ke branch (`git push origin feature/amazing-feature`)
6. Buat Pull Request

## 📄 Konvensi Kode

### Widget Naming
- Halaman: `{feature}_page.dart`
- Widget: `{feature}_widget.dart`
- Contoh: `home_page.dart`, `product_card_widget.dart`

### Route Naming
Setiap page harus mendefinisikan:
```dart
static const routeName = 'home-page';
static const routePath = '/home';
```

### State Management
- Menggunakan `StatefulWidget` dengan local state
- Belum menggunakan BLOC/Riverpod (akan ditambahkan di masa depan)

### Comments
- Gunakan DartDoc (`///`) untuk widget publik
- Komentar inline minimal

## 📝 Project Status

### Completed Features ✅
- Home page with promo carousel
- Product catalog & detail pages
- Shopping cart functionality
- Checkout flow (address, shipping, payment)
- Authentication pages (login, register)
- Base navigation with bottom nav bar
- Feature widgets (product cards, cart items, etc.)

### In Progress 🚧
- Profile page
- Backend integration
- Payment gateway integration

### Planned 📌
- Order history
- Wishlist feature
- Product search & filters
- User reviews & ratings
- Push notifications
- Multi-language support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Bima Surya** - Initial work

## 🙏 Acknowledgments

- Flutter Team untuk amazing framework
- Beads untuk issue tracking system
- Google untuk Fonts & Material Design

---

**Dibuat dengan ❤️ menggunakan Flutter**
