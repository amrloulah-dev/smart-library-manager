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
[![Azure OCR](https://img.shields.io/badge/AI-Azure_OCR-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/)
<br />

<!-- DOWNLOAD BUTTON -->
<a href="https://drive.google.com/drive/folders/1XCZH4j01MpMJBykdbk25tXJMt0xC_viE?usp=drive_link" target="_blank">
  <img src="https://img.shields.io/badge/Download_Demo_APK-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" height="40" />
</a>

<br />
<br />

The **Smart Library Manager** is an advanced, offline-first Flutter application designed to revolutionize library and bookstore management. It bridges the gap between traditional ERP systems and modern AI-driven business intelligence.

</div>

---

## 📸 App Screenshots

| Dashboard & Analytics | Point of Sale (POS) | Invoice OCR Scanning | Inventory Management |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/Dashboard.png" width="200"/> | <img src="assets/screenshots/POS.png" width="200"/> | <img src="assets/screenshots/OCR.png" width="200"/> | <img src="assets/screenshots/Inventory.png" width="200"/> |

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


```
<div align="center">
Developed with ❤️ by <a href="https://github.com/amrloulah-dev">Amr Loulah</a>
</div>
