import 'package:librarymanager/core/database/app_database.dart';

enum InsightType { positive, negative, none }

class SupplierReportModel {
  final Supplier supplier;
  final InsightType insightType;
  final String? insightMessage;

  const SupplierReportModel({
    required this.supplier,
    this.insightType = InsightType.none,
    this.insightMessage,
  });
}
