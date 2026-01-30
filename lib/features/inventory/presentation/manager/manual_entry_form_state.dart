import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/constants/book_constants.dart';

class ManualEntryFormState extends Equatable {
  final String? publisher;
  final String? subject;
  final String? grade;
  final String? term;
  final List<String> publishersList;
  final String generatedName;

  const ManualEntryFormState({
    this.publisher,
    this.subject,
    this.grade,
    this.term,
    this.publishersList = BookConstants.publishers,
    this.generatedName = '',
  });

  ManualEntryFormState copyWith({
    String? publisher,
    String? subject,
    String? grade,
    String? term,
    List<String>? publishersList,
    String? generatedName,
  }) {
    return ManualEntryFormState(
      publisher: publisher ?? this.publisher,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      term: term ?? this.term,
      publishersList: publishersList ?? this.publishersList,
      generatedName: generatedName ?? this.generatedName,
    );
  }

  @override
  List<Object?> get props => [
    publisher,
    subject,
    grade,
    term,
    publishersList,
    generatedName,
  ];
}
