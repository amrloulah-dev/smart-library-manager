import 'package:equatable/equatable.dart';

class BookSearchQuery extends Equatable {
  final String? publisher;
  final String? subject;
  final String? grade;
  final String? term;
  final String? part;

  const BookSearchQuery({
    this.publisher,
    this.subject,
    this.grade,
    this.term,
    this.part,
  });

  @override
  List<Object?> get props => [publisher, subject, grade, term, part];

  @override
  String toString() {
    return 'BookSearchQuery(publisher: $publisher, subject: $subject, grade: $grade, term: $term, part: $part)';
  }
}
