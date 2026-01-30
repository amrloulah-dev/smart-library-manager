import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/dropdown_cubit.dart';

class FilterDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;

  const FilterDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  void _toggleDropdown(BuildContext context) {
    context.read<DropdownCubit>().toggle();
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    final menuWidth = 200.w;

    double dx = 0;
    if (offset.dx + menuWidth > screenWidth - 20) {
      dx = -(menuWidth - size.width);
    }

    // We must capture the Cubit to pass it to the Overlay if needed,
    // or just handle the overlay's "Dismiss" by calling the cubit.
    // Since the overly is in a Stack with a GestureDetector for dismissal:
    final cubit = context.read<DropdownCubit>();

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          // Dismiss barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: () => cubit.hide(),
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown content
          Positioned(
            width: menuWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(dx, size.height + 8.h),
              child: Material(
                elevation: 8,
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 250.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2439),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: widget.items.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            'No items',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          shrinkWrap: true,
                          itemCount: widget.items.length,
                          separatorBuilder: (c, i) =>
                              const Divider(color: Colors.white12, height: 1),
                          itemBuilder: (context, index) {
                            final item = widget.items[index];
                            final isSelected = item == widget.selectedItem;

                            return InkWell(
                              onTap: () {
                                widget.onChanged(item);
                                cubit.hide();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.primaryBlue.withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF22D3EE)
                                              : Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: const Color(0xFF22D3EE),
                                        size: 18.sp,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DropdownCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<DropdownCubit, bool>(
            listener: (context, isOpen) {
              if (isOpen) {
                _showOverlay(context);
              } else {
                _hideOverlay();
              }
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: () => _toggleDropdown(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: widget.selectedItem != null
                        ? const Color(0xFF3B82F6).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: widget.selectedItem != null
                          ? const Color(0xFF3B82F6)
                          : Colors.white24,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.selectedItem ?? widget.label,
                        style: TextStyle(
                          color: widget.selectedItem != null
                              ? const Color(0xFF3B82F6)
                              : Colors.white,
                          fontSize: 12.sp,
                          fontWeight: widget.selectedItem != null
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      BlocBuilder<DropdownCubit, bool>(
                        builder: (context, isOpen) {
                          return Icon(
                            isOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: widget.selectedItem != null
                                ? const Color(0xFF3B82F6)
                                : Colors.white54,
                            size: 16.sp,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
