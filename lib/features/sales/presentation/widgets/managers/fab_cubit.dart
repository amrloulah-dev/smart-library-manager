import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FabCubit extends Cubit<bool> {
  FabCubit() : super(false);

  void toggle() => emit(!state);
  void expand() => emit(true);
  void collapse() => emit(false);
}
