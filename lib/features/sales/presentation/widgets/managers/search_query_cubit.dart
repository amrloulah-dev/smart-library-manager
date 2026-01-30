import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchQueryCubit extends Cubit<String> {
  SearchQueryCubit() : super('');

  void updateQuery(String query) => emit(query);
  void clear() => emit('');
}
