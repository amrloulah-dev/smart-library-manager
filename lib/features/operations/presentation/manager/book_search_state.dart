import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

class BookSearchState extends Equatable {
  final List<Book> results;
  final bool isSearching;

  const BookSearchState({this.results = const [], this.isSearching = false});

  @override
  List<Object> get props => [results, isSearching];
}
