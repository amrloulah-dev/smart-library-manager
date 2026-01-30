import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarymanager/core/constants/book_constants.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_invoice_state.dart';
import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_entry_form_cubit.dart';
import 'package:librarymanager/features/inventory/presentation/manager/manual_entry_form_state.dart';

class ManualEntrySheet extends StatefulWidget {
  final Function(ManualInvoiceItem) onAdd;
  final bool isReturnMode;

  const ManualEntrySheet({
    super.key,
    required this.onAdd,
    this.isReturnMode = false,
  });

  @override
  State<ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends State<ManualEntrySheet> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Book? _selectedBook;

  @override
  void initState() {
    super.initState();
    _qtyController.addListener(_updateState);
    _costController.addListener(_updateState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _costController.dispose();
    _sellPriceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _updateState() {
    // Just to trigger rebuild if needed, e.g. for button validation
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ManualEntryFormCubit>(),
      child: BlocConsumer<ManualEntryFormCubit, ManualEntryFormState>(
        listener: (context, state) {
          // If generated name changes, update controller
          // But check if it differs to avoid cursor jumps or loops if we had two-way binding (which we don't fully here)
          if (state.generatedName.isNotEmpty &&
              _nameController.text != state.generatedName) {
            _nameController.text = state.generatedName;
          }
        },
        builder: (context, state) {
          final cubit = context.read<ManualEntryFormCubit>();

          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
              left: 16.w,
              right: 16.w,
              top: 24.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Title
                Text(
                  widget.isReturnMode ? 'إضافة كتاب للمرتجع' : 'إضافة صنف جديد',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),

                // Name Field
                widget.isReturnMode
                    ? _buildBookAutocomplete(context, cubit)
                    : _buildTextField(
                        controller: _nameController,
                        hint: 'اسم الكتاب',
                        icon: Icons.menu_book,
                      ),
                SizedBox(height: 16.h),

                // Dropdown Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        'الناشر',
                        state.publisher,
                        [...state.publishersList, 'إضافة ناشر جديد...'],
                        (val) async {
                          if (val == 'إضافة ناشر جديد...') {
                            final newPub = await _showAddPublisherDialog();
                            if (newPub != null && newPub.trim().isNotEmpty) {
                              cubit.addPublisher(newPub);
                            }
                          } else if (val != null) {
                            cubit.setPublisher(val);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDropdown(
                        'المادة',
                        state.subject,
                        BookConstants.subjects,
                        (val) {
                          if (val != null) cubit.setSubject(val);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        'الصف',
                        state.grade,
                        BookConstants.grades,
                        (val) {
                          if (val != null) cubit.setGrade(val);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDropdown(
                        'الترم',
                        state.term,
                        BookConstants.terms,
                        (val) {
                          if (val != null) cubit.setTerm(val);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Stats Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _qtyController,
                        hint: 'الكمية',
                        isNumber: true,
                        icon: Icons.inventory_2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _costController,
                        hint: 'الشراء',
                        isNumber: true,
                        isDecimal: true,
                        icon: Icons.account_balance_wallet,
                        textAlign: TextAlign.center,
                        enabled: !widget.isReturnMode,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _sellPriceController,
                        hint: 'البيع',
                        isNumber: true,
                        isDecimal: true,
                        icon: Icons.sell,
                        textAlign: TextAlign.center,
                        enabled: !widget.isReturnMode,
                      ),
                    ),
                  ],
                ),

                if (widget.isReturnMode) ...[
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _stockController,
                    hint: 'المخزن الحالي',
                    isNumber: true,
                    icon: Icons.storage,
                    enabled: false,
                    textAlign: TextAlign.center,
                  ),
                ],

                SizedBox(height: 32.h),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _submitItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isReturnMode
                          ? Colors.orangeAccent
                          : const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      widget.isReturnMode
                          ? 'إضافة لقائمة المرتجع'
                          : 'إضافة صنف',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitItem() {
    if (_nameController.text.isEmpty) return;

    final int qty = int.tryParse(_qtyController.text) ?? 0;
    final double cost = double.tryParse(_costController.text) ?? 0.0;
    final double sell = double.tryParse(_sellPriceController.text) ?? 0.0;

    if (qty <= 0) return;

    if (widget.isReturnMode && _selectedBook != null) {
      if (qty > _selectedBook!.currentStock) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الكمية المرتجعة أكبر من المخزن المتاح'),
          ),
        );
        return;
      }
    }

    final item = ManualInvoiceItem(
      bookName: _nameController.text,
      quantity: qty,
      costPrice: cost,
      sellPrice: sell,
      bookId: _selectedBook?.id,
    );

    widget.onAdd(item);
  }

  Widget _buildBookAutocomplete(
    BuildContext context,
    ManualEntryFormCubit cubit,
  ) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        return StreamBuilder<List<Book>>(
          stream: context.read<InventoryCubit>().booksStream,
          builder: (context, snapshot) {
            final List<Book> books = snapshot.data ?? [];

            return Autocomplete<Book>(
              displayStringForOption: (Book b) => b.name,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<Book>.empty();
                }
                return books.where((Book b) {
                  return b.name.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              onSelected: (Book b) {
                setState(() {
                  _selectedBook = b;
                  // Fields
                  _costController.text = b.costPrice.toString();
                  _sellPriceController.text = b.sellPrice.toString();
                  _stockController.text = b.currentStock.toString();
                });
                // Update Form Cubit
                cubit.setFromBook(b);
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                // Sync controller text if generated name changes
                // Or keep it as is. Autocomplete uses its own controller usually?
                // The example uses 'controller' provided by fieldViewBuilder.
                // We need to ensure _nameController is this controller?
                // Actually, Autocomplete manages its own controller if not provided?
                // No, fieldViewBuilder provides one.
                // If we want _nameController to be the one:
                if (controller.text != _nameController.text) {
                  controller.text = _nameController.text;
                }
                // Wait, we can't easily swap controllers.
                // Instead, we just use the one provided, and listen to it or sync.
                // But _submitItem uses _nameController.

                // Simple fix: Update _nameController when this changes.
                controller.addListener(() {
                  if (_nameController.text != controller.text) {
                    _nameController.text = controller.text;
                  }
                });

                // Also if _nameController updates (from Cubit), we update this one.
                // But we are inside BlocBuilder, not Listener.
                // The Listener above updates _nameController.

                return _buildTextField(
                  controller: controller,
                  hint: 'ابحث عن الكتاب...',
                  icon: Icons.search,
                  focusNode: focusNode,
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    color: const Color(0xFF1E2439),
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: 320.w,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Book option = options.elementAt(index);
                          return InkWell(
                            onTap: () => onSelected(option),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Text(
                                option.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<String?> _showAddPublisherDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2439),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'إضافة ناشر جديد',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
          textAlign: TextAlign.right,
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'اسم الناشر',
            hintStyle: TextStyle(color: Colors.grey[500]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: TextStyle(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text('إضافة', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isNumber = false,
    bool isDecimal = false,
    bool enabled = true,
    TextAlign textAlign = TextAlign.start,
    FocusNode? focusNode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        textAlign: textAlign,
        keyboardType: isNumber
            ? TextInputType.numberWithOptions(decimal: isDecimal)
            : TextInputType.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: isNumber ? FontWeight.w600 : FontWeight.normal,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 11.sp),
          prefixIcon: Icon(icon, color: Colors.grey[400], size: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
          ),
          dropdownColor: const Color(0xFF1E2439),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[400],
            size: 20.sp,
          ),
          isExpanded: true,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            );
          }).toList(),
          onChanged: (val) {
            onChanged(val);
          },
        ),
      ),
    );
  }
}
