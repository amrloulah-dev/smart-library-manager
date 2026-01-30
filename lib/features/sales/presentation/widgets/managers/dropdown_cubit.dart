import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class DropdownCubit extends Cubit<bool> {
  // Initial state: Closed (false)
  DropdownCubit() : super(false);

  void toggle() => emit(!state);
  void hide() => emit(false);
  void open() => emit(true);
}
