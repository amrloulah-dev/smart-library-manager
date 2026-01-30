import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'sync_repository.dart';

@singleton
class SyncWorker {
  final SyncRepository _syncRepository;
  Timer? _timer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  SyncWorker(this._syncRepository);

  void start() {
    // 1. Initial Sync Attempt
    _syncRepository.pushChanges();

    // 2. Schedule Periodic Sync (Every 15 minutes)
    _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      _syncRepository.pushChanges();
    });

    // 3. Listen to Connectivity Changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (!results.contains(ConnectivityResult.none)) {
        // Internet became available, try syncing immediately
        _syncRepository.pushChanges();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _connectivitySubscription?.cancel();
  }
}
