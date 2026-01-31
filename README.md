<div align="center">

# 📚 Smart Library Manager
### Offline-First & AI-Powered ERP Solution for Bookstores

<!-- Badges -->
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?style=for-the-badge&logo=dart)](https://dart.dev/)
[![Clean Architecture](https://img.shields.io/badge/Clean-Architecture-success?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![Offline First](https://img.shields.io/badge/Offline-First-important?style=for-the-badge)]()

<!-- Tech Stack Badges -->
[![Bloc](https://img.shields.io/badge/State-Bloc_Cubit-red?style=flat-square)]()
[![Drift](https://img.shields.io/badge/DB-Drift_(SQLite)-003B57?style=flat-square)]()
[![Supabase](https://img.shields.io/badge/Cloud-Supabase-3ECF8E?style=flat-square)]()
[![OCR](https://img.shields.io/badge/AI-Tesseract_OCR-yellow?style=flat-square)]()

<br />

<!-- DOWNLOAD BUTTON -->
<!-- استبدل اللينك ده برابط جوجل درايف الخاص بيك -->
<a href="PUT_YOUR_GOOGLE_DRIVE_LINK_HERE">
  <img src="https://img.shields.io/badge/Download_Demo_APK-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" height="40" />
</a>

<br />
<br />

The **Smart Library Manager** is an advanced, offline-first Flutter application designed to revolutionize library and bookstore management. It bridges the gap between traditional ERP systems and modern AI-driven business intelligence.

</div>

---

## 📸 App Screenshots

<!-- استبدل الروابط دي بروابط الصور الحقيقية بتاعتك بعد ما ترفعها -->
| Dashboard & Analytics | Point of Sale (POS) | Invoice OCR Scanning | Inventory Management |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/dashboard.png" width="200"/> | <img src="assets/screenshots/pos.png" width="200"/> | <img src="assets/screenshots/ocr.png" width="200"/> | <img src="assets/screenshots/inventory.png" width="200"/> |

---

## 🚀 Key Features

### 🧠 AI-Powered Business Intelligence
*   **Stock Health Index:** Real-time scoring of inventory health.
*   **Smart Risk Analysis:**
    *   🚨 **Time Traps:** Identifies items unlikely to sell before deadlines.
    *   💀 **Dead Stock (Coma):** Flags items with zero sales velocity (30+ days).
    *   📉 **Early Failures:** Detects new products performing below thresholds.
*   **Restock Suggestions:** AI-driven purchasing recommendations based on sales velocity and seasonal trends.

### 📚 Advanced Inventory & OCR
*   **Seamless Digitization:** Integrated **Tesseract OCR** (Arabic support) to scan paper invoices and auto-fill data.
*   **Supplier Relations:** Track performance, return policies, and credit balances.
*   **Batch Operations:** Bulk import/export capabilities.

### 💰 Professional Point of Sale (POS)
*   **Streamlined Checkout:** Fast processing for sales, returns, and exchanges.
*   **Dynamic Pricing:** Manage discounts and customer debts on the fly.
*   **Customer Profiles:** Comprehensive history tracking and credit management.

### 🔄 Robust Architecture
*   **Offline-First Core:** Built on **Drift (SQLite)** ensuring 100% functionality without internet.
*   **Auto-Sync Engine:** Background service that synchronizes local changes with **Supabase** when connectivity is restored.

---

## 🛠️ Technology Stack

| Category | Technology |
|:--- |:--- |
| **Framework** | Flutter (Dart 3.x) |
| **State Management** | `flutter_bloc` (Cubits) |
| **Architecture** | Clean Architecture (Feature-First) |
| **DI** | `get_it`, `injectable` |
| **Local Database** | `drift` (SQLite) |
| **Remote Backend** | `supabase_flutter` |
| **AI & OCR** | `flutter_tesseract_ocr`, `google_mlkit` |
| **UI/UX** | `flutter_screenutil`, `fl_chart`, `google_fonts`, `flutter_animate` |

---

## 📂 Project Structure

The project follows a scalable **Feature-First Clean Architecture**:

```text
lib/
├── app/                  # App configuration & Routing
├── core/                 # Shared Kernel (Theme, Errors, Utils)
│   ├── database/         # Drift Schema & DAOs
│   └── services/         # Sync, OCR, & Background Workers
├── features/             # Modular Features
│   ├── dashboard/        # BI & Analytics
│   ├── inventory/        # Stock Logic
│   ├── invoices/         # OCR Scanning
│   ├── sales/            # POS System
│   └── ...
└── main.dart             # Entry Point
⚙️ Setup & Installation
Clone the repository:
code
Bash
git clone https://github.com/amrloulah-dev/smart-library-manager.git
Install Dependencies:
code
Bash
flutter pub get
Run Code Generation:
code
Bash
dart run build_runner build --delete-conflicting-outputs
Run the App:
code
Bash
flutter run
📝 Note on Security
Note: API Keys (Supabase/Azure) have been removed for security purposes. If you want to run this project, please provide your own keys in lib/core/constants/.
<div align="center">
<div align="center">
Developed with ❤️ by <a href="https://github.com/amrloulah-dev">Amr Loulah</a>
</div>
```
```
