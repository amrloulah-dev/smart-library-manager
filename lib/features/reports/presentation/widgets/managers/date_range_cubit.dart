import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DateRangeCubit extends Cubit<List<DateTime?>> {
  DateRangeCubit() : super([]);

  void updateDates(List<DateTime?> dates) => emit(dates);
  void clear() => emit([]);
}
