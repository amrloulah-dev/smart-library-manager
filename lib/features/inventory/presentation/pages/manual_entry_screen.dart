import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarymanager/app/injection.dart';
import 'package:librarymanager/core/constants/book_constants.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_entry_cubit.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_entry_state.dart';

class ManualEntryScreen extends StatelessWidget {
  const ManualEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManualEntryCubit>(),
      child: const _ManualEntryView(),
    );
  }
}

class _ManualEntryView extends StatelessWidget {
  const _ManualEntryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Entry (إضافة يدوي)')),
      body: BlocConsumer<ManualEntryCubit, ManualEntryState>(
        listener: (context, state) {
          if (state.status == ManualEntryStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error occurred')),
            );
            context.read<ManualEntryCubit>().resetStatus();
          }
          if (state.status == ManualEntryStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم حفظ الكتاب بنجاح! 💾')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.status == ManualEntryStatus.loading) {
            return const Center(child: CustomLoadingIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPreviewCard(state),
                const SizedBox(height: 24),
                _buildDropdowns(context, state),
                const SizedBox(height: 24),
                _buildInputs(context, state),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<ManualEntryCubit>().submitBook(
                      state.sellPrice.toString(),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save to Inventory 💾'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPreviewCard(ManualEntryState state) {
    return Card(
      elevation: 4,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Generated Name:', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              state.generatedName.isEmpty ? '---' : state.generatedName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            if (state.existingBook != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '✅ Available: ${state.existingBook!.currentStock} copies',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDropdowns(BuildContext context, ManualEntryState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _DropdownField(
                label: 'Publisher (الناشر)',
                value: state.publisher,
                items: BookConstants.publishers,
                onChanged: (val) =>
                    context.read<ManualEntryCubit>().updatePublisher(val),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DropdownField(
                label: 'Subject (المادة)',
                value: state.subject,
                items: BookConstants.subjects,
                onChanged: (val) =>
                    context.read<ManualEntryCubit>().updateSubject(val),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _DropdownField(
                label: 'Grade (الصف)',
                value: state.grade,
                items: BookConstants.grades,
                onChanged: (val) =>
                    context.read<ManualEntryCubit>().updateGrade(val),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DropdownField(
                label: 'Term (الترم)',
                value: state.term,
                items: BookConstants.terms,
                onChanged: (val) =>
                    context.read<ManualEntryCubit>().updateTerm(val),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputs(BuildContext context, ManualEntryState state) {
    // We use keys to update text fields if state changes from external source (like finding book)
    // But text controllers are usually better.
    // Since we are using BLoC, let's use key to force rebuild or controller.
    // For simplicity, InitialValue works if the widget rebuilds with new key.
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: ValueKey('qty_${state.existingBook?.id}'),
            initialValue: state.quantity > 0 ? state.quantity.toString() : '',
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
              suffixText: 'pcs',
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) =>
                context.read<ManualEntryCubit>().updateQuantity(val),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            key: ValueKey('cost_${state.existingBook?.id}'),
            initialValue: state.costPrice > 0
                ? state.costPrice.toStringAsFixed(2)
                : '',
            decoration: const InputDecoration(
              labelText: 'Cost Price',
              border: OutlineInputBorder(),
              prefixText: 'EGP ',
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) =>
                context.read<ManualEntryCubit>().updateCostPrice(val),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            key: ValueKey('sell_${state.existingBook?.id}'),
            initialValue: state.sellPrice > 0
                ? state.sellPrice.toStringAsFixed(2)
                : '',
            decoration: const InputDecoration(
              labelText: 'Sell Price',
              border: OutlineInputBorder(),
              prefixText: 'EGP ',
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) =>
                context.read<ManualEntryCubit>().updateSellPrice(val),
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }
}
