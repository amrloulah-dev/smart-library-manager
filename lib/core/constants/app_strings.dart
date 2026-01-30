/// Centralized Arabic strings for the application.
/// This file contains all UI labels and messages to improve maintainability.
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // ============ Navigation & Tabs ============
  static const String inventory = 'المخزن';
  static const String pos = 'الكاشير';
  static const String relations = 'العلاقات';
  static const String reports = 'التقارير';
  static const String dashboard = 'الرئيسية';

  // ============ Common Actions ============
  static const String confirm = 'تأكيد';
  static const String cancel = 'إلغاء';
  static const String save = 'حفظ';
  static const String delete = 'حذف';
  static const String edit = 'تعديل';
  static const String add = 'إضافة';
  static const String search = 'بحث';
  static const String close = 'إغلاق';
  static const String done = 'تم';
  static const String retry = 'إعادة المحاولة';
  static const String viewAll = 'عرض الكل';
  static const String activate = 'تفعيل';

  // ============ Dashboard ============
  static const String sales = 'المبيعات';
  static const String shortages = 'نواقص';
  static const String returns = 'مرتجع';
  static const String cashInDrawer = 'الرصيد';
  static const String aiAnalysis = 'تحليل الذكاء الاصطناعي';
  static const String aiInsightSample =
      'إجمالى المبيعات هذا الشهر أعلى بنسبة 15%';
  static const String recentOperations = 'آخر العمليات';
  static const String saleOperation = 'عملية بيع';
  static const String minutesAgo = 'منذ 15 دقيقة';
  static const String completed = 'مكتملة';

  // ============ POS Screen ============
  static const String tapToActivateScanner = 'اضغط لتفعيل الماسح';
  static const String manualEntry = 'إدخال يدوي';
  static const String invoiceList = 'قائمة الفاتورة';
  static const String emptyCart = 'السلة فارغة';
  static const String total = 'الإجمالي';
  static const String collectCash = 'تحصيل (كاش)';
  static const String checkout = 'إتمام البيع';
  static const String customerReturn = 'مرتجع عميل';
  static const String exchange = 'استبدال';

  // ============ Inventory Screen ============
  static const String searchByNameOrAuthor = 'بحث باسم الكتاب أو المؤلف...';
  static const String noResults = 'لا توجد نتائج';
  static const String scanInvoice = 'امسح الفاتورة ضوئيًا 📸';
  static const String manualInvoice = 'فاتورة يدوية ✍️';
  static const String lowStock = 'مخزون منخفض';
  static const String bestSeller = 'الأكثر مبيعاً';
  static const String reserved = 'محجوز';
  static const String all = 'الكل';
  static const String noBooks = 'لا توجد كتب';
  static const String searchBook = 'بحث عن كتاب...';

  // ============ Relations Screen ============
  static const String suppliers = 'الموردين';
  static const String customers = 'العملاء';
  static const String reservations = 'الحجوزات';
  static const String totalDebt = 'إجمالي المديونية';
  static const String totalCredit = 'إجمالي الائتمان';
  static const String totalPaid = 'المدفوع';
  static const String addSupplier = 'إضافة مورد';
  static const String addCustomer = 'إضافة عميل';
  static const String addReservation = 'إضافة حجز';
  static const String customerName = 'اسم العميل';
  static const String phone = 'رقم الهاتف';
  static const String deposit = 'العربون';
  static const String bookName = 'اسم الكتاب';

  // ============ Reports Screen ============
  static const String financialReport = 'التقارير المالية';
  static const String inventoryReport = 'تقرير المخزون';
  static const String salesReport = 'تقرير المبيعات';
  static const String totalSales = 'إجمالي المبيعات';
  static const String cashSales = 'مبيعات نقدية';
  static const String creditSales = 'مبيعات آجلة';
  static const String expenses = 'المصروفات';
  static const String netProfit = 'صافي الربح';
  static const String cogs = 'تكلفة البضاعة';
  static const String grossProfit = 'إجمالي الأرباح';

  // ============ Checkout ============
  static const String paymentMethod = 'طريقة الدفع';
  static const String cash = 'كاش';
  static const String credit = 'آجل';
  static const String discount = 'الخصم';
  static const String paidAmount = 'المبلغ المدفوع';
  static const String changeAmount = 'الباقي';
  static const String completeSale = 'إتمام البيع';

  // ============ Invoice ============
  static const String supplier = 'المورد';
  static const String invoiceDate = 'تاريخ الفاتورة';
  static const String items = 'الأصناف';
  static const String quantity = 'الكمية';
  static const String unitPrice = 'سعر الوحدة';
  static const String totalPrice = 'الإجمالي';
  static const String addItem = 'إضافة صنف';
  static const String saveInvoice = 'حفظ الفاتورة';

  // ============ Settings ============
  static const String settings = 'الإعدادات';
  static const String smartSettings = 'الإعدادات الذكية';
  static const String seasonEndDate = 'تاريخ نهاية الموسم';
  static const String gradeTargets = 'أهداف الصفوف';

  // ============ Errors & Messages ============
  static const String error = 'خطأ';
  static const String errorOccurred = 'حدث خطأ';
  static const String loadingFailed = 'فشل التحميل';
  static const String noData = 'لا توجد بيانات';
  static const String success = 'تم بنجاح';
  static const String addedSuccessfully = 'تمت الإضافة بنجاح';
  static const String savedSuccessfully = 'تم الحفظ بنجاح';
  static const String deletedSuccessfully = 'تم الحذف بنجاح';

  // ============ Currency ============
  static const String egp = 'ج.م';
  static const String sar = 'ج.م';
}
