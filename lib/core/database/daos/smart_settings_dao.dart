import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';

part 'smart_settings_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [GradeTargets, AppSettings])
class SmartSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SmartSettingsDaoMixin {
  SmartSettingsDao(super.db);

  Future<DateTime?> getSeasonEndDate() async {
    final settings = await select(appSettings).getSingleOrNull();
    return settings?.seasonEndDate;
  }

  Future<void> setSeasonEndDate(DateTime date) async {
    final settings = await select(appSettings).getSingleOrNull();
    if (settings != null) {
      // Update existing
      await update(
        appSettings,
      ).replace(settings.copyWith(seasonEndDate: Value(date)));
    } else {
      // Insert new
      await into(appSettings).insert(
        AppSettingsCompanion.insert(
          seasonEndDate: Value(date),
          defaultLeadTime: const Value(3), // Default from requirements
        ),
      );
    }
  }

  Future<int?> getTargetForGrade(String grade) async {
    final target = await (select(
      gradeTargets,
    )..where((t) => t.grade.equals(grade))).getSingleOrNull();
    return target?.studentCount;
  }

  Future<void> setTargetForGrade(String grade, int count) async {
    // Check if exists by grade since ID is UUID and we don't know it
    final existing = await (select(
      gradeTargets,
    )..where((t) => t.grade.equals(grade))).getSingleOrNull();

    if (existing != null) {
      await update(
        gradeTargets,
      ).replace(existing.copyWith(studentCount: count));
    } else {
      await into(
        gradeTargets,
      ).insert(GradeTargetsCompanion.insert(grade: grade, studentCount: count));
    }
  }

  Future<Map<String, int>> getAllGradeTargets() async {
    final targets = await select(gradeTargets).get();
    return {for (var t in targets) t.grade: t.studentCount};
  }

  /// Updates license information in local storage for offline validation.
  Future<void> updateLicenseInfo({
    required String key,
    required DateTime expiry,
    required String status,
  }) async {
    final settings = await select(appSettings).getSingleOrNull();
    if (settings != null) {
      // Update existing
      await update(appSettings).replace(
        settings.copyWith(
          licenseKey: Value(key),
          licenseExpiryDate: Value(expiry),
          licenseStatus: status,
        ),
      );
    } else {
      // Insert new
      await into(appSettings).insert(
        AppSettingsCompanion.insert(
          licenseKey: Value(key),
          licenseExpiryDate: Value(expiry),
          licenseStatus: Value(status),
        ),
      );
    }
  }

  /// Gets the current license information from local storage.
  Future<({String? key, DateTime? expiry, String status})>
  getLicenseInfo() async {
    final settings = await select(appSettings).getSingleOrNull();
    return (
      key: settings?.licenseKey,
      expiry: settings?.licenseExpiryDate,
      status: settings?.licenseStatus ?? 'inactive',
    );
  }

  /// Checks if the license is valid for offline access.
  Future<bool> isLicenseValid() async {
    final info = await getLicenseInfo();
    if (info.status != 'active') return false;
    if (info.expiry == null) return false;
    return info.expiry!.isAfter(DateTime.now());
  }

  /// Clears license information (used when signing out).
  Future<void> clearLicenseInfo() async {
    final settings = await select(appSettings).getSingleOrNull();
    if (settings != null) {
      await update(appSettings).replace(
        settings.copyWith(
          licenseKey: const Value(null),
          licenseExpiryDate: const Value(null),
          licenseStatus: 'inactive',
        ),
      );
    }
  }
}
