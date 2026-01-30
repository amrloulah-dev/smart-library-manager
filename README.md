# Smart Library Manager

A professional, offline-first Flutter application designed for advanced library and bookstore management. This system integrates Point of Sale (POS) operations, comprehensive inventory control, and AI-driven business intelligence to optimize stock levels and financial performance.

## 🚀 Project Overview

**Library Manager** solves the challenge of managing complex book inventories by combining traditional ERP features with intelligent decision-support algorithms. It is designed to work seamlessly offline, synchronizing data with a cloud backend (Supabase) when connectivity is available.

The application primarily targets the Arabic market (`ar` locale) with a dedicated Dark Mode UI.

## ✨ Key Features

### 🧠 Business Intelligence & AI
- **Stock Health Index**: Real-time scoring of inventory health based on shortages and stagnation.
- **Risk Analysis Algorithms**:
  - **Time Traps**: Identifies items unlikely to sell before their return deadline.
  - **Dead Stock (Coma)**: Flags items with zero sales velocity over 30+ days.
  - **Early Failures**: Detects new products performing below sales thresholds.
- **Restock Suggestions**: Generates purchasing recommendations considering sales velocity, seasonal trends, and market saturation.
- **Sales Forecasting**: Predictive analytics for future sales growth.

### 📚 Inventory Management
- **Book Tracking**: Detailed management of ISBNs, editions, grades, and subjects.
- **Supplier Relations**: Track supplier performance, return policies, and credit balances.
- **OCR Invoice Scanning**: Integrated **Tesseract OCR** (Arabic support) to digitize paper invoices automatically.
- **Batch Operations**: Support for manual entry and bulk import workflows.

### 💰 Point of Sale (POS)
- **Transaction Processing**: Streamlined checkout for sales, returns, and exchanges.
- **Financial Tools**: Management of discounts, dynamic pricing, and customer debts.
- **Customer Profiles**: History tracking and credit/reservation management.

### 🔄 Architecture & Data
- **Offline-First**: Built on **Drift (SQLite)** for instant local data access.
- **Auto-Sync**: Background service that synchronizes local changes with **Supabase**, handling conflict resolution and data integrity.
- **Clean Architecture**: Modular feature-based structure ensuring testability and separation of concerns.

## 🛠 Technology Stack

- **Framework**: Flutter (Dart 3.x)
- **State Management**: `flutter_bloc` (Cubits)
- **Dependency Injection**: `get_it`, `injectable`
- **Navigation**: `go_router`
- **Local Database**: `drift` (SQLite)
- **Backend/Cloud**: `supabase_flutter`
- **OCR & AI**: `flutter_tesseract_ocr`, `google_mlkit_text_recognition`
- **UI/UX**: `flutter_screenutil`, `fl_chart`, `google_fonts`, `flutter_animate`

## 📂 Project Structure

The project follows a **Feature-First Clean Architecture**:

```text
lib/
├── app/                  # App configuration, routing (GoRouter), and DI setup
├── core/                 # Shared infrastructure
│   ├── database/         # Drift database schema and DAOs
│   ├── services/         # Sync, OCR, and background workers
│   ├── theme/            # AppTheme (Dark Mode configuration)
│   └── utils/            # Helpers for math, formatting, and file handling
├── features/             # Business features (Clean Architecture layers)
│   ├── auth/             # Authentication & Licensing
│   ├── dashboard/        # Main navigation shell
│   ├── inventory/        # Book & Supplier management
│   ├── invoices/         # Invoice scanning & processing
│   ├── operations/       # Expenses & Reservations
│   ├── relations/        # Customer management
│   ├── reports/          # BI logic, risk analysis, and charts
│   └── sales/            # POS & Cart functionality
└── main.dart             # Entry point & Initialization
```

## ⚙️ Setup & Usage

### Prerequisites
- **Flutter SDK**: (Version compatible with `pubspec.yaml`, typically stable)
- **Supabase Account**: Required for the cloud backend.
- **Tesseract Data**: Arabic training data (`ara.traineddata`) in `assets/tessdata/`.

### Configuration
1.  **Environment Variables**:
    Ensure `lib/core/constants/app_constants.dart` is configured with your Supabase URL and Anon Key.

2.  **Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Code Generation**:
    Run `build_runner` to generate files for Drift, Injectable, and JSON serialization:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

### Running the App
```bash
flutter run
```

## 📝 Notes & Limitations

- **Theme**: The application is strictly **Dark Mode** (`AppTheme.darkTheme`).
- **Localization**: The default and primary locale is **Arabic (`ar`)**.
- **OCR**: Requires the `ara.traineddata` file to be present in the device assets for Arabic text recognition to function.
- **Sync**: The `SupabaseSyncService` is designed to run on app start and connectivity changes; ensure network permissions are granted.

## 🔮 Future Considerations

- **Azure Integration**: Architecture allows for plugging in Azure Cognitive Services for enhanced OCR/Analysis.
- **Multi-Branch Support**: Database schemas include `libraryId`, paving the way for multi-tenant deployments.