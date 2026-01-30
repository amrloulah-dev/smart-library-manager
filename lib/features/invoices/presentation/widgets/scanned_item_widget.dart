import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/features/invoices/presentation/manager/invoice_scanner_cubit.dart';

class ScannedItemWidget extends StatefulWidget {
  final ScannedItemModel item;
  final int index;

  const ScannedItemWidget({super.key, required this.item, required this.index});

  @override
  State<ScannedItemWidget> createState() => _ScannedItemWidgetState();
}

class _ScannedItemWidgetState extends State<ScannedItemWidget> {
  late TextEditingController _nameController;
  late TextEditingController _qtyController;
  late TextEditingController _costController;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();
  final FocusNode _costFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _qtyController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    _costController = TextEditingController(
      text: widget.item.price.toStringAsFixed(2),
    );

    _nameFocus.addListener(_onNameFocusChange);
    _qtyFocus.addListener(_onQtyFocusChange);
    _costFocus.addListener(_onCostFocusChange);
  }

  @override
  void didUpdateWidget(covariant ScannedItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item != widget.item) {
      // Update controllers if the item changes from outside (e.g. recalculation)
      // BUT only if we are not currently editing that specific field
      if (!_nameFocus.hasFocus && _nameController.text != widget.item.name) {
        _nameController.text = widget.item.name;
      }
      if (!_qtyFocus.hasFocus &&
          int.tryParse(_qtyController.text) != widget.item.quantity) {
        _qtyController.text = widget.item.quantity.toString();
      }
      if (!_costFocus.hasFocus &&
          double.tryParse(_costController.text) != widget.item.price) {
        _costController.text = widget.item.price.toStringAsFixed(2);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _costController.dispose();
    _nameFocus.dispose();
    _qtyFocus.dispose();
    _costFocus.dispose();
    super.dispose();
  }

  void _onNameFocusChange() {
    if (!_nameFocus.hasFocus) {
      _updateName();
    }
  }

  void _onQtyFocusChange() {
    if (!_qtyFocus.hasFocus) {
      _updateQty();
    }
  }

  void _onCostFocusChange() {
    if (!_costFocus.hasFocus) {
      _updateCost();
    }
  }

  void _updateName() {
    if (_nameController.text != widget.item.name) {
      context.read<InvoiceScannerCubit>().updateScannedItem(
        widget.index,
        name: _nameController.text,
      );
    }
  }

  void _updateQty() {
    final qty = int.tryParse(_qtyController.text);
    if (qty != null && qty != widget.item.quantity) {
      context.read<InvoiceScannerCubit>().updateScannedItem(
        widget.index,
        qty: qty,
      );
    }
  }

  void _updateCost() {
    final cost = double.tryParse(_costController.text);
    if (cost != null && cost != widget.item.price) {
      context.read<InvoiceScannerCubit>().updateScannedItem(
        widget.index,
        cost: cost,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMismatch = widget.item.hasCalculationMismatch;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(12.r),
        border: hasMismatch
            ? Border.all(color: AppTheme.roseRed, width: 2)
            : Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delete Button
              IconButton(
                onPressed: () => context.read<InvoiceScannerCubit>().removeItem(
                  widget.index,
                ),
                icon: Icon(
                  Icons.delete_outline,
                  color: AppTheme.roseRed,
                  size: 24.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              SizedBox(width: 8.w),

              // Book Name Field
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'اسم الكتاب',
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  onFieldSubmitted: (_) => _updateName(),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Numeric Fields Row
          Row(
            children: [
              // Quantity
              Expanded(
                child: _buildCompactField(
                  controller: _qtyController,
                  focusNode: _qtyFocus,
                  label: 'الكمية',
                  isNumber: true,
                  onSubmitted: (_) => _updateQty(),
                ),
              ),
              SizedBox(width: 8.w),

              // Cost Price
              Expanded(
                child: _buildCompactField(
                  controller: _costController,
                  focusNode: _costFocus,
                  label: 'شراء',
                  isNumber: true,
                  isDecimal: true,
                  onSubmitted: (_) => _updateCost(),
                ),
              ),
              SizedBox(width: 8.w),

              // Selling Price (Calculated)
              Expanded(
                child: _buildReadOnlyField(
                  label: 'بيع (تلقائي)',
                  value: widget.item.sellPrice?.toStringAsFixed(1) ?? '-',
                  isMajor: true, // Make it prominent
                  textColor: const Color(0xFF10B981), // Emerald Green
                ),
              ),
              SizedBox(width: 8.w),

              // Total (Read-only)
              Expanded(
                child: _buildReadOnlyField(
                  label: 'الإجمالي',
                  value: (widget.item.quantity * widget.item.price)
                      .toStringAsFixed(1),
                  isMajor: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required Function(String) onSubmitted,
    bool isNumber = false,
    bool isDecimal = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: isNumber
              ? TextInputType.numberWithOptions(decimal: isDecimal)
              : TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 8.w,
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    bool isMajor = false,
    Color? textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isMajor
                ? (textColor?.withOpacity(0.1) ??
                      const Color(0xFF3B82F6).withOpacity(0.1))
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            value,
            style: TextStyle(
              color:
                  textColor ??
                  (isMajor ? const Color(0xFF3B82F6) : Colors.white),
              fontSize: 14.sp,
              fontWeight: isMajor ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
