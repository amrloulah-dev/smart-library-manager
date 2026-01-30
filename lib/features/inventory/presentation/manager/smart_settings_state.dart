part of 'smart_settings_cubit.dart';

abstract class SmartSettingsState extends Equatable {
  const SmartSettingsState();

  @override
  List<Object?> get props => [];
}

class SmartSettingsLoading extends SmartSettingsState {}

class SmartSettingsLoaded extends SmartSettingsState {
  final DateTime? seasonEndDate;
  final Map<String, int> gradeTargets;

  const SmartSettingsLoaded({this.seasonEndDate, required this.gradeTargets});

  @override
  List<Object?> get props => [seasonEndDate, gradeTargets];
}

class SmartSettingsError extends SmartSettingsState {
  final String message;

  const SmartSettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
