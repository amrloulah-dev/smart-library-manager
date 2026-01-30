import 'package:equatable/equatable.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_stats.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_detail_model.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/domain/models/financial_report.dart';

class DashboardStats extends Equatable {
  final double salesToday;
  final double expensesToday;
  final double netProfitToday;
  final double cashInDrawer;
  final int lowStockCount;
  final int returnsCount;
  final int debtsCount;
  final int booksSoldToday;
  final List<Sale> recentSales;

  final String aiInsight;
  final bool isPositiveInsight;

  const DashboardStats({
    this.salesToday = 0.0,
    this.expensesToday = 0.0,
    this.netProfitToday = 0.0,
    this.cashInDrawer = 0.0,
    this.lowStockCount = 0,
    this.returnsCount = 0,
    this.debtsCount = 0,
    this.booksSoldToday = 0,
    this.recentSales = const [],
    this.aiInsight = '',
    this.isPositiveInsight = true,
  });

  @override
  List<Object> get props => [
    salesToday,
    expensesToday,
    netProfitToday,
    cashInDrawer,
    lowStockCount,
    returnsCount,
    debtsCount,
    booksSoldToday,
    recentSales,
    aiInsight,
    isPositiveInsight,
  ];
}

abstract class ReportsRepository {
  Future<DashboardStats> getDashboardStats();
  Stream<DashboardStats> getDashboardStatsStream();
  Future<List<Book>> getLowStockBooks();
  Future<List<Book>> getTopProfitBooks();
  Future<List<Supplier>> getTopSuppliers();
  Future<List<Supplier>> getSuppliersReport();
  Stream<List<Supplier>> getSuppliersReportStream();
  Future<List<Book>> getDeadStockBooks();
  Future<List<Book>> getAllBooks();
  Future<Map<String, int>> getSalesInLast30Days();

  Future<List<DailySalesPoint>> getSalesChartData(DateTime start, DateTime end);
  Future<FinancialReport> getFinancialReport(DateTime start, DateTime end);
  Stream<FinancialReport> getFinancialReportStream(
    DateTime start,
    DateTime end,
  );
  Future<SupplierStats> getSupplierStats(String supplierId);
  Future<InvoiceDetailModel> getInvoiceDetails(String invoiceId);
  Future<double> getTotalSalesMTD(DateTime startOfMonth, DateTime now);
  Future<int> getTotalCurrentStock();

  /// Calculates total inventory value treating negative stock as zero
  Future<double> getTotalInventoryValue();

  /// Calculates total paid amount (Invoices Initial Paid + Supplier Separate Payments)
  Future<double> getTotalPaidToSuppliers();
}
