import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/theme/app_theme.dart';

import 'package:librarymanager/features/inventory/domain/models/inventory_filter.dart';

class InventoryFilterList extends StatelessWidget {
  final InventoryFilter activeFilter;
  final ValueChanged<InventoryFilter> onSelected;

  const InventoryFilterList({
    super.key,
    required this.activeFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Map of Enum to Display Label
    final Map<InventoryFilter, String> filterLabels = {
      InventoryFilter.all: 'الكل',
      InventoryFilter.lowStock: 'منخفض المخزون',
      InventoryFilter.bestSeller: 'الأكثر مبيعاً',
      InventoryFilter.reserved: 'محجوز',
    };

    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: InventoryFilter.values.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = InventoryFilter.values[index];
          final isSelected = filter == activeFilter;
          final label = filterLabels[filter] ?? '';

          return ChoiceChip(
            label: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                onSelected(filter);
              }
            },
            selectedColor: AppTheme.primaryBlue,
            backgroundColor: AppTheme.glassyDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide.none,
            ),
            showCheckmark: false,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          );
        },
      ),
    );
  }
}
