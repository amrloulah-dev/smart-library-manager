import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';

part 'smart_settings_state.dart';

@injectable
class SmartSettingsCubit extends Cubit<SmartSettingsState> {
  final InventoryRepository _repository;

  SmartSettingsCubit(this._repository) : super(SmartSettingsLoading());

  Future<void> loadSettings() async {
    emit(SmartSettingsLoading());
    try {
      final seasonEndDate = await _repository.getSeasonEndDate();
      final gradeTargets = await _repository.getAllGradeTargets();

      emit(
        SmartSettingsLoaded(
          seasonEndDate: seasonEndDate,
          gradeTargets: gradeTargets,
        ),
      );
    } catch (e) {
      emit(SmartSettingsError(e.toString()));
    }
  }

  Future<void> saveSettings({
    required DateTime? seasonEndDate,
    required Map<String, int> gradeTargets,
  }) async {
    emit(SmartSettingsLoading());
    try {
      if (seasonEndDate != null) {
        await _repository.setSeasonEndDate(seasonEndDate);
      }

      for (var entry in gradeTargets.entries) {
        await _repository.setTargetForGrade(entry.key, entry.value);
      }

      // Re-load to show latest state
      loadSettings();
      // Optionally emit Saved state if UI needs to react specifically (like navigation pop)
      // For now, re-loading will show the data on screen.
      // Actually, standard pattern is to emit a specialized state or use a listener in UI.
      // Let's emit Loaded again but maybe with a "success" flag or just rely on re-rendering.
      // Or we can emit Saved state.
    } catch (e) {
      emit(SmartSettingsError(e.toString()));
    }
  }
}
