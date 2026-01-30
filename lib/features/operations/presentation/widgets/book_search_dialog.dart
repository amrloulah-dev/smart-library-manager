import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/operations/presentation/manager/book_search_cubit.dart';
import 'package:librarymanager/features/operations/presentation/manager/book_search_state.dart';

class BookSearchDialog extends StatefulWidget {
  final String title;
  final Function(Book) onBookSelected;

  const BookSearchDialog({
    super.key,
    required this.title,
    required this.onBookSelected,
  });

  @override
  State<BookSearchDialog> createState() => _BookSearchDialogState();
}

class _BookSearchDialogState extends State<BookSearchDialog> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<BookSearchCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<BookSearchCubit>();

          return AlertDialog(
            title: Text(widget.title),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<BookSearchCubit, BookSearchState>(
                    builder: (context, state) {
                      return TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search Books',
                          hintText: 'Enter book name',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: state.isSearching
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CustomLoadingIndicator(size: 20),
                                  ),
                                )
                              : null,
                        ),
                        onChanged: cubit.search,
                        autofocus: true,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<BookSearchCubit, BookSearchState>(
                    builder: (context, state) {
                      if (state.results.isEmpty && !state.isSearching) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Search for a book to link',
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      if (state.results.isNotEmpty) {
                        return Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final book = state.results[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: book.currentStock > 0
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    book.currentStock.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(book.name),
                                subtitle: Text(
                                  'Stock: ${book.currentStock} | \$${book.sellPrice.toStringAsFixed(2)}',
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () => widget.onBookSelected(book),
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      ),
    );
  }
}
