import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/app.dart';
import 'app/injection.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/tess_file_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/services/supabase_sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  await TessFileHandler.ensureLanguageFileExists();

  await configureDependencies();

  // Initialize Offline-First Sync
  final syncService = getIt<SupabaseSyncService>();
  // 1. Initial Sync
  syncService.syncPendingData();
  // 2. Connectivity Listener
  Connectivity().onConnectivityChanged.listen((
    List<ConnectivityResult> results,
  ) {
    if (!results.contains(ConnectivityResult.none)) {
      syncService.syncPendingData();
    }
  });

  runApp(const LibraryManagerApp());
}
