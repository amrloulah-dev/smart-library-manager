// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../core/database/app_database.dart' as _i935;
import '../core/database/daos/books_dao.dart' as _i831;
import '../core/database/daos/customers_dao.dart' as _i1005;
import '../core/database/daos/expenses_dao.dart' as _i1035;
import '../core/database/daos/sales_dao.dart' as _i720;
import '../core/database/daos/smart_settings_dao.dart' as _i787;
import '../core/database/daos/suppliers_dao.dart' as _i896;
import '../core/di/third_party_module.dart' as _i1048;
import '../core/services/supabase_sync_service.dart' as _i721;
import '../core/services/sync_repository.dart' as _i358;
import '../core/services/sync_worker.dart' as _i153;
import '../core/services/tesseract_ocr_service.dart' as _i539;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/presentation/manager/auth_cubit.dart' as _i10;
import '../features/inventory/data/repositories/inventory_repository_impl.dart'
    as _i1045;
import '../features/inventory/domain/repositories/inventory_repository.dart'
    as _i617;
import '../features/inventory/domain/services/spine_mapping_service.dart'
    as _i1005;
import '../features/inventory/presentation/manager/inventory_cubit.dart'
    as _i558;
import '../features/inventory/presentation/manager/item_history_cubit.dart'
    as _i221;
import '../features/inventory/presentation/manager/manual_entry_cubit.dart'
    as _i893;
import '../features/inventory/presentation/manager/manual_entry_form_cubit.dart'
    as _i506;
import '../features/inventory/presentation/manager/manual_invoice_cubit.dart'
    as _i54;
import '../features/inventory/presentation/manager/smart_settings_cubit.dart'
    as _i274;
import '../features/inventory/presentation/manager/supplier_return_cubit.dart'
    as _i109;
import '../features/invoices/data/datasources/azure_invoice_service.dart'
    as _i1065;
import '../features/invoices/data/repositories/invoice_repository_impl.dart'
    as _i597;
import '../features/invoices/domain/repositories/invoice_repository.dart'
    as _i19;
import '../features/invoices/presentation/manager/invoice_scanner_cubit.dart'
    as _i675;
import '../features/operations/data/repositories/expenses_repository_impl.dart'
    as _i504;
import '../features/operations/data/repositories/reservations_repository_impl.dart'
    as _i775;
import '../features/operations/domain/repositories/expenses_repository.dart'
    as _i846;
import '../features/operations/domain/repositories/reservations_repository.dart'
    as _i372;
import '../features/operations/presentation/manager/book_search_cubit.dart'
    as _i647;
import '../features/operations/presentation/manager/expense_form_cubit.dart'
    as _i865;
import '../features/operations/presentation/manager/expenses_cubit.dart'
    as _i373;
import '../features/operations/presentation/manager/reservation_form_cubit.dart'
    as _i308;
import '../features/relations/data/repositories/relations_repository_impl.dart'
    as _i108;
import '../features/relations/domain/repositories/relations_repository.dart'
    as _i1012;
import '../features/relations/presentation/manager/customers_bloc.dart'
    as _i1043;
import '../features/reports/data/repositories/reports_repository_impl.dart'
    as _i1028;
import '../features/reports/domain/repositories/reports_repository.dart'
    as _i1053;
import '../features/reports/domain/services/business_intelligence_service.dart'
    as _i264;
import '../features/reports/presentation/manager/ai_summary_cubit.dart'
    as _i877;
import '../features/reports/presentation/manager/bi_cubit.dart' as _i259;
import '../features/reports/presentation/manager/cash_flow_cubit.dart' as _i274;
import '../features/reports/presentation/manager/dashboard_cubit.dart' as _i779;
import '../features/reports/presentation/manager/detailed_reports_cubit.dart'
    as _i34;
import '../features/reports/presentation/manager/financial_report_filter_cubit.dart'
    as _i464;
import '../features/reports/presentation/manager/inventory_value_cubit.dart'
    as _i208;
import '../features/reports/presentation/manager/invoice_details_cubit.dart'
    as _i200;
import '../features/reports/presentation/manager/invoices_history_cubit.dart'
    as _i309;
import '../features/reports/presentation/manager/returns_form_cubit.dart'
    as _i783;
import '../features/reports/presentation/manager/sales_details_cubit.dart'
    as _i789;
import '../features/reports/presentation/manager/shortages_cubit.dart' as _i510;
import '../features/reports/presentation/manager/supplier_details_cubit.dart'
    as _i456;
import '../features/reports/presentation/manager/suppliers_report_cubit.dart'
    as _i948;
import '../features/reports/presentation/widgets/managers/date_range_cubit.dart'
    as _i584;
import '../features/sales/data/repositories/customers_repository_impl.dart'
    as _i986;
import '../features/sales/data/repositories/sales_repository_impl.dart'
    as _i980;
import '../features/sales/domain/repositories/customers_repository.dart'
    as _i37;
import '../features/sales/domain/repositories/sales_repository.dart' as _i391;
import '../features/sales/domain/usecases/scan_book_usecase.dart' as _i395;
import '../features/sales/presentation/manager/customers_cubit.dart' as _i661;
import '../features/sales/presentation/manager/exchange_cubit.dart' as _i127;
import '../features/sales/presentation/manager/relations_cubit.dart' as _i112;
import '../features/sales/presentation/manager/sales_cubit.dart' as _i1023;
import '../features/sales/presentation/widgets/managers/dropdown_cubit.dart'
    as _i183;
import '../features/sales/presentation/widgets/managers/fab_cubit.dart'
    as _i558;
import '../features/sales/presentation/widgets/managers/sales_search_cubit.dart'
    as _i951;
import '../features/sales/presentation/widgets/managers/search_query_cubit.dart'
    as _i1038;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    gh.factory<_i506.ManualEntryFormCubit>(() => _i506.ManualEntryFormCubit());
    gh.factory<_i865.ExpenseFormCubit>(() => _i865.ExpenseFormCubit());
    gh.factory<_i464.FinancialReportFilterCubit>(
      () => _i464.FinancialReportFilterCubit(),
    );
    gh.factory<_i783.ReturnsFormCubit>(() => _i783.ReturnsFormCubit());
    gh.factory<_i584.DateRangeCubit>(() => _i584.DateRangeCubit());
    gh.factory<_i183.DropdownCubit>(() => _i183.DropdownCubit());
    gh.factory<_i558.FabCubit>(() => _i558.FabCubit());
    gh.factory<_i1038.SearchQueryCubit>(() => _i1038.SearchQueryCubit());
    gh.lazySingleton<_i935.AppDatabase>(() => _i935.AppDatabase());
    gh.lazySingleton<_i454.SupabaseClient>(
      () => thirdPartyModule.supabaseClient,
    );
    gh.lazySingleton<_i539.TesseractOcrService>(
      () => _i539.TesseractOcrService(),
    );
    gh.lazySingleton<_i1005.SpineMappingService>(
      () => _i1005.SpineMappingService(),
    );
    gh.lazySingleton<_i1065.AzureInvoiceService>(
      () => _i1065.AzureInvoiceService(),
    );
    gh.lazySingleton<_i372.ReservationsRepository>(
      () => _i775.ReservationsRepositoryImpl(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i19.InvoiceRepository>(
      () => _i597.InvoiceRepositoryImpl(),
    );
    gh.lazySingleton<_i1012.RelationsRepository>(
      () => _i108.RelationsRepositoryImpl(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i831.BooksDao>(
      () => _i831.BooksDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i1005.CustomersDao>(
      () => _i1005.CustomersDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i1035.ExpensesDao>(
      () => _i1035.ExpensesDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i720.SalesDao>(
      () => _i720.SalesDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i787.SmartSettingsDao>(
      () => _i787.SmartSettingsDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i896.SuppliersDao>(
      () => _i896.SuppliersDao(gh<_i935.AppDatabase>()),
    );
    gh.lazySingleton<_i869.AuthRepository>(
      () => _i570.AuthRepositoryImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i264.BusinessIntelligenceService>(
      () => _i264.BusinessIntelligenceService(
        gh<_i720.SalesDao>(),
        gh<_i787.SmartSettingsDao>(),
        gh<_i831.BooksDao>(),
      ),
    );
    gh.lazySingleton<_i721.SupabaseSyncService>(
      () => _i721.SupabaseSyncService(
        gh<_i935.AppDatabase>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i358.SyncRepository>(
      () => _i358.SyncRepository(
        gh<_i935.AppDatabase>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i1053.ReportsRepository>(
      () => _i1028.ReportsRepositoryImpl(
        gh<_i720.SalesDao>(),
        gh<_i831.BooksDao>(),
        gh<_i896.SuppliersDao>(),
        gh<_i1035.ExpensesDao>(),
        gh<_i935.AppDatabase>(),
      ),
    );
    gh.lazySingleton<_i617.InventoryRepository>(
      () => _i1045.InventoryRepositoryImpl(
        gh<_i831.BooksDao>(),
        gh<_i896.SuppliersDao>(),
        gh<_i935.AppDatabase>(),
        gh<_i787.SmartSettingsDao>(),
      ),
    );
    gh.factory<_i789.SalesDetailsCubit>(
      () => _i789.SalesDetailsCubit(gh<_i720.SalesDao>()),
    );
    gh.factory<_i309.InvoicesHistoryCubit>(
      () => _i309.InvoicesHistoryCubit(
        gh<_i935.AppDatabase>(),
        gh<_i617.InventoryRepository>(),
      ),
    );
    gh.lazySingleton<_i37.CustomersRepository>(
      () => _i986.CustomersRepositoryImpl(gh<_i1005.CustomersDao>()),
    );
    gh.lazySingleton<_i846.ExpensesRepository>(
      () => _i504.ExpensesRepositoryImpl(gh<_i1035.ExpensesDao>()),
    );
    gh.factory<_i510.ShortagesCubit>(
      () => _i510.ShortagesCubit(
        gh<_i372.ReservationsRepository>(),
        gh<_i264.BusinessIntelligenceService>(),
        gh<_i831.BooksDao>(),
      ),
    );
    gh.lazySingleton<_i558.InventoryCubit>(
      () => _i558.InventoryCubit(
        gh<_i617.InventoryRepository>(),
        gh<_i264.BusinessIntelligenceService>(),
      ),
    );
    gh.lazySingleton<_i391.SalesRepository>(
      () => _i980.SalesRepositoryImpl(
        gh<_i935.AppDatabase>(),
        gh<_i720.SalesDao>(),
        gh<_i1005.CustomersDao>(),
        gh<_i831.BooksDao>(),
      ),
    );
    gh.singleton<_i153.SyncWorker>(
      () => _i153.SyncWorker(gh<_i358.SyncRepository>()),
    );
    gh.factory<_i1043.CustomersBloc>(
      () => _i1043.CustomersBloc(gh<_i37.CustomersRepository>()),
    );
    gh.factory<_i274.CashFlowCubit>(
      () => _i274.CashFlowCubit(
        gh<_i391.SalesRepository>(),
        gh<_i846.ExpensesRepository>(),
      ),
    );
    gh.factory<_i893.ManualEntryCubit>(
      () => _i893.ManualEntryCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i54.ManualInvoiceCubit>(
      () => _i54.ManualInvoiceCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i109.SupplierReturnCubit>(
      () => _i109.SupplierReturnCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i308.ReservationFormCubit>(
      () => _i308.ReservationFormCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i661.CustomersCubit>(
      () => _i661.CustomersCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i951.SalesSearchCubit>(
      () => _i951.SalesSearchCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i675.InvoiceScannerCubit>(
      () => _i675.InvoiceScannerCubit(
        gh<_i1065.AzureInvoiceService>(),
        gh<_i617.InventoryRepository>(),
      ),
    );
    gh.factory<_i779.DashboardCubit>(
      () => _i779.DashboardCubit(gh<_i1053.ReportsRepository>()),
    );
    gh.factory<_i34.DetailedReportsCubit>(
      () => _i34.DetailedReportsCubit(gh<_i1053.ReportsRepository>()),
    );
    gh.factory<_i208.InventoryValueCubit>(
      () => _i208.InventoryValueCubit(gh<_i1053.ReportsRepository>()),
    );
    gh.factory<_i456.SupplierDetailsCubit>(
      () => _i456.SupplierDetailsCubit(gh<_i1053.ReportsRepository>()),
    );
    gh.factory<_i948.SuppliersReportCubit>(
      () => _i948.SuppliersReportCubit(gh<_i1053.ReportsRepository>()),
    );
    gh.factory<_i10.AuthCubit>(
      () => _i10.AuthCubit(
        gh<_i869.AuthRepository>(),
        gh<_i787.SmartSettingsDao>(),
      ),
    );
    gh.factory<_i877.AiSummaryCubit>(
      () => _i877.AiSummaryCubit(
        gh<_i1053.ReportsRepository>(),
        gh<_i264.BusinessIntelligenceService>(),
      ),
    );
    gh.factory<_i259.BiCubit>(
      () => _i259.BiCubit(
        gh<_i1053.ReportsRepository>(),
        gh<_i264.BusinessIntelligenceService>(),
      ),
    );
    gh.lazySingleton<_i395.ScanBookUseCase>(
      () => _i395.ScanBookUseCase(
        gh<_i539.TesseractOcrService>(),
        gh<_i1005.SpineMappingService>(),
        gh<_i617.InventoryRepository>(),
      ),
    );
    gh.factory<_i127.ExchangeCubit>(
      () => _i127.ExchangeCubit(gh<_i391.SalesRepository>()),
    );
    gh.factory<_i112.RelationsCubit>(
      () => _i112.RelationsCubit(
        gh<_i37.CustomersRepository>(),
        gh<_i372.ReservationsRepository>(),
        gh<_i617.InventoryRepository>(),
        gh<_i1012.RelationsRepository>(),
      ),
    );
    gh.factory<_i200.InvoiceDetailsCubit>(
      () => _i200.InvoiceDetailsCubit(
        gh<_i1053.ReportsRepository>(),
        gh<_i617.InventoryRepository>(),
      ),
    );
    gh.factory<_i373.ExpensesCubit>(
      () => _i373.ExpensesCubit(gh<_i846.ExpensesRepository>()),
    );
    gh.factory<_i221.ItemHistoryCubit>(
      () => _i221.ItemHistoryCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i274.SmartSettingsCubit>(
      () => _i274.SmartSettingsCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i647.BookSearchCubit>(
      () => _i647.BookSearchCubit(gh<_i617.InventoryRepository>()),
    );
    gh.factory<_i1023.SalesCubit>(
      () => _i1023.SalesCubit(
        gh<_i395.ScanBookUseCase>(),
        gh<_i617.InventoryRepository>(),
        gh<_i391.SalesRepository>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i1048.ThirdPartyModule {}
