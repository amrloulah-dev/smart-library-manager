import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/app/main_layout.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/utils/router_utils.dart';
import 'package:librarymanager/features/auth/presentation/manager/auth_cubit.dart';
import 'package:librarymanager/features/auth/presentation/pages/login_screen.dart';
import 'package:librarymanager/features/auth/presentation/pages/register_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/dashboard_screen.dart';
import 'package:librarymanager/features/inventory/presentation/pages/books_screen.dart';
import 'package:librarymanager/features/inventory/presentation/pages/manual_invoice_screen.dart';
import 'package:librarymanager/features/inventory/presentation/pages/supplier_return_screen.dart';
import 'package:librarymanager/features/inventory/presentation/pages/suppliers_screen.dart';
import 'package:librarymanager/features/invoices/presentation/pages/invoice_scanner_screen.dart';
import 'package:librarymanager/features/sales/presentation/pages/relations_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/reports_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/supplier_details_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/cash_flow_screen.dart';

import 'package:librarymanager/features/reports/presentation/pages/shortages_screen.dart';
import 'package:librarymanager/features/sales/presentation/pages/pos_screen.dart';
import 'package:librarymanager/features/sales/presentation/pages/exchange_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_cubit.dart';

import 'package:librarymanager/features/invoices/presentation/manager/invoice_scanner_cubit.dart';
import 'package:librarymanager/features/sales/presentation/manager/sales_cubit.dart';
import 'package:librarymanager/features/reports/presentation/manager/shortages_cubit.dart';
import 'package:librarymanager/features/reports/presentation/manager/sales_details_cubit.dart';
import 'package:librarymanager/features/reports/presentation/pages/sales_details_screen.dart';
import 'package:librarymanager/features/inventory/presentation/manager/item_history_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/pages/item_history_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/business_intelligence_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/invoices_history_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/invoice_details_screen.dart';
import 'package:librarymanager/features/reports/presentation/pages/ai_summary_screen.dart';
import 'package:librarymanager/features/reports/presentation/manager/ai_summary_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/smart_settings_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/pages/smart_settings_screen.dart';

import 'package:librarymanager/features/auth/presentation/pages/license_expired_screen.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/', // Start directly at Dashboard
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final authState = authCubit.state;

      // Define status booleans
      final bool isLoggedIn = authState is Authenticated;
      final bool isUnauthenticated = authState is Unauthenticated;
      final bool isLicenseExpired = authState is AuthLicenseExpired;

      // Note: If isLoading, we currently do nothing and stay on the initial route (Dashboard)
      // which creates an optimistic load feel or "instant app" feel.

      // Define location booleans
      final bool isGoingToLogin = state.matchedLocation == '/login';
      final bool isGoingToRegister = state.matchedLocation == '/register';
      final bool isGoingToLicenseExpired =
          state.matchedLocation == '/license_expired';

      // 1. If Unauthenticated
      if (isUnauthenticated) {
        // If already on login/register, do nothing
        return (isGoingToLogin || isGoingToRegister) ? null : '/login';
      }

      // 2. If License Expired
      if (isLicenseExpired) {
        return isGoingToLicenseExpired ? null : '/license_expired';
      }

      // 3. If Authenticated
      if (isLoggedIn) {
        // If on login/register/license_expired, move to Dashboard
        if (isGoingToLogin || isGoingToRegister || isGoingToLicenseExpired) {
          return '/';
        }
        // Otherwise let them go (e.g. /pos, /inventory)
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/license_expired',
        builder: (context, state) => const LicenseExpiredScreen(),
      ),
      GoRoute(
        path: '/cash_flow',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CashFlowScreen(),
      ),
      GoRoute(
        path: '/risky_books',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SupplierReturnScreen(),
      ),
      GoRoute(
        path: '/shortages',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ShortagesCubit>(),
          child: const ShortagesScreen(),
        ),
      ),
      GoRoute(
        path: '/sales_details',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SalesDetailsCubit>()..fetchSalesData(),
          child: const SalesDetailsScreen(),
        ),
      ),
      GoRoute(
        path: '/supplier_details',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final supplier = state.extra as Supplier;
          return SupplierDetailsScreen(supplier: supplier);
        },
      ),
      GoRoute(
        path: '/invoices_history',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final supplier = state.extra as Supplier;
          return InvoicesHistoryScreen(supplier: supplier);
        },
      ),
      GoRoute(
        path: '/invoice_details',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final invoiceId = state.extra as String;
          return InvoiceDetailsScreen(invoiceId: invoiceId);
        },
      ),
      GoRoute(
        path: '/bi_insights',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BusinessIntelligenceScreen(),
      ),
      GoRoute(
        path: '/ai_summary',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AiSummaryCubit>()..loadAiSummary(),
          child: const AiSummaryScreen(),
        ),
      ),
      GoRoute(
        path: '/smart_settings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SmartSettingsCubit>(),
          child: const SmartSettingsScreen(),
        ),
      ),
      GoRoute(
        path: '/item_history',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final book = state.extra as Book;
          return BlocProvider(
            create: (context) =>
                getIt<ItemHistoryCubit>()..loadHistory(book.id),
            child: ItemHistoryScreen(book: book),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // 1. Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          // 2. Inventory
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inventory',
                builder: (context, state) {
                  final cubit = getIt<InventoryCubit>();
                  // Initial load if never loaded
                  if (cubit.state is InventoryInitial) {
                    cubit.loadBooks(isRefresh: true);
                  }
                  return BlocProvider.value(
                    value: cubit,
                    child: const BooksScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'manual_entry',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BlocProvider(
                      create: (context) => getIt<ManualInvoiceCubit>(),
                      child: const ManualInvoiceScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'manual_invoice',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BlocProvider(
                      create: (context) => getIt<ManualInvoiceCubit>(),
                      child: const ManualInvoiceScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'supplier_return',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const SupplierReturnScreen(),
                  ),
                  GoRoute(
                    path: 'suppliers',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BlocProvider.value(
                      value: getIt<InventoryCubit>(),
                      child: const SuppliersScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'invoice_scanner',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BlocProvider(
                      create: (context) => getIt<InvoiceScannerCubit>(),
                      child: const InvoiceScannerScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'item_history',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final book = state.extra as Book;
                      return BlocProvider(
                        create: (context) => getIt<ItemHistoryCubit>(),
                        child: ItemHistoryScreen(book: book),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // 3. POS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pos',
                builder: (context, state) {
                  String? bookId;
                  // Safely handle state.extra as either String or Map
                  if (state.extra is String) {
                    bookId = state.extra as String;
                  } else if (state.extra is Map<String, dynamic>) {
                    bookId = (state.extra as Map<String, dynamic>)['bookId']
                        ?.toString();
                  }

                  return BlocProvider(
                    create: (context) => getIt<SalesCubit>(),
                    child: PosScreen(bookId: bookId),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'exchange',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const ExchangeScreen(),
                  ),
                ],
              ),
            ],
          ),
          // 4. Relations
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/relations',
                builder: (context, state) => const RelationsScreen(),
              ),
            ],
          ),
          // 5. Reports
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
}
