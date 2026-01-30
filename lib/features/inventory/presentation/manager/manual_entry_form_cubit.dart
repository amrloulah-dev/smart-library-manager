import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'manual_entry_form_state.dart';

@injectable
class ManualEntryFormCubit extends Cubit<ManualEntryFormState> {
  ManualEntryFormCubit() : super(const ManualEntryFormState());

  void setPublisher(String val) {
    if (val == 'إضافة ناشر جديد...') {
      return; // Handle this in UI or separate action
    }
    // If it's a new publisher not in list, we add it?
    // The UI calls addPublisher first.
    emit(state.copyWith(publisher: val));
    _generateName();
  }

  void addPublisher(String newPub) {
    if (newPub.trim().isEmpty) return;
    final trimmed = newPub.trim();
    final currentList = List<String>.from(state.publishersList);
    if (!currentList.contains(trimmed)) {
      currentList.add(trimmed);
      emit(state.copyWith(publishersList: currentList));
    }
    setPublisher(trimmed);
  }

  void setSubject(String val) {
    emit(state.copyWith(subject: val));
    _generateName();
  }

  void setGrade(String val) {
    emit(state.copyWith(grade: val));
    _generateName();
  }

  void setTerm(String val) {
    emit(state.copyWith(term: val));
    _generateName();
  }

  void _generateName() {
    final parts = [
      state.publisher,
      state.subject,
      state.grade,
      state.term,
    ].where((e) => e != null && e.isNotEmpty).toList();

    if (parts.isNotEmpty) {
      emit(state.copyWith(generatedName: parts.join(' ')));
    }
  }

  void setFromBook(Book book) {
    emit(
      state.copyWith(
        publisher: book.publisher,
        subject: book.subject,
        grade: book.grade,
        term: book.term,
        generatedName: book.name,
      ),
    );
  }
}
