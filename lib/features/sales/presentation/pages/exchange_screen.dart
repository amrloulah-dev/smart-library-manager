import 'package:flutter/material.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/sales/presentation/manager/exchange_cubit.dart';
import 'package:librarymanager/features/sales/presentation/widgets/sales_search_bottom_sheet.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ExchangeCubit>(),
      child: const _ExchangeScreenContent(),
    );
  }
}

class _ExchangeScreenContent extends StatelessWidget {
  const _ExchangeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Exchange'), centerTitle: true),
      body: BlocConsumer<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          if (state.status == ExchangeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم الاستبدال بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context); // Go back after success
          } else if (state.status == ExchangeStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  // Returned Items (Top Half)
                  Expanded(
                    child: Container(
                      color: Colors.red.withOpacity(0.05),
                      child: Column(
                        children: [
                          _buildSectionHeader(
                            context,
                            title: 'Returned Items (مرتجع)',
                            color: Colors.red,
                            onAdd: () =>
                                _showSearchSheet(context, isReturn: true),
                          ),
                          Expanded(
                            child: _buildItemsList(
                              context,
                              items: state.returnedItems,
                              isReturn: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // New Items (Bottom Half)
                  Expanded(
                    child: Container(
                      color: Colors.green.withOpacity(0.05),
                      child: Column(
                        children: [
                          _buildSectionHeader(
                            context,
                            title: 'New Items (جديد)',
                            color: Colors.green,
                            onAdd: () =>
                                _showSearchSheet(context, isReturn: false),
                          ),
                          Expanded(
                            child: _buildItemsList(
                              context,
                              items: state.newItems,
                              isReturn: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state.status == ExchangeStatus.loading
                                ? null
                                : () => context
                                      .read<ExchangeCubit>()
                                      .confirmExchange(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.status == ExchangeStatus.loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CustomLoadingIndicator(size: 20),
                                  )
                                : const Text(
                                    'Confirm Exchange 🔄',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Floating Net Difference Bubble
              Positioned(
                left: 0,
                right: 0,
                top:
                    MediaQuery.of(context).size.height * 0.4 -
                    40, // Approximate center
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        color: state.netDifference > 0
                            ? Colors.green
                            : state.netDifference < 0
                            ? Colors.red
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.netDifference > 0
                              ? 'Customer Pays'
                              : state.netDifference < 0
                              ? 'Refund'
                              : 'Balanced',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: state.netDifference > 0
                                ? Colors.green
                                : state.netDifference < 0
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          state.netDifference.abs().toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: state.netDifference > 0
                                ? Colors.green
                                : state.netDifference < 0
                                ? Colors.red
                                : Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required Color color,
    required VoidCallback onAdd,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border(bottom: BorderSide(color: color.withOpacity(0.2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add'),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(
    BuildContext context, {
    required List<Book> items,
    required bool isReturn,
  }) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          isReturn ? 'No items to return' : 'No new items added',
          style: TextStyle(color: Colors.grey[500]),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final book = items[index];
        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(book.name),
            subtitle: Text(
              '${book.sellPrice.toStringAsFixed(2)} EGP',
              style: TextStyle(
                color: isReturn ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () {
                if (isReturn) {
                  context.read<ExchangeCubit>().removeReturnedItem(book);
                } else {
                  context.read<ExchangeCubit>().removeNewItem(book);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showSearchSheet(BuildContext context, {required bool isReturn}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SalesSearchBottomSheet(
        onBookSelected: (book) {
          if (isReturn) {
            context.read<ExchangeCubit>().addReturnedItem(book);
          } else {
            context.read<ExchangeCubit>().addNewItem(book);
          }
        },
      ),
    );
  }
}
