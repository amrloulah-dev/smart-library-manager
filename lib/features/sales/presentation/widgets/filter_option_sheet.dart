import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/core/theme/app_theme.dart';

class FilterOptionSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onSelect;

  const FilterOptionSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content height
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // List
          Flexible(
            // Use Flexible to allow list to take available space up to max height
            child: Container(
              constraints: BoxConstraints(maxHeight: 400.h), // Limit height
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: options.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = option == selectedValue;

                  return InkWell(
                    onTap: () {
                      onSelect(option);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: TextStyle(
                              color: isSelected
                                  ? AppTheme.primaryBlue
                                  : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: AppTheme.primaryBlue,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Footer (Clear Filter)
          TextButton(
            onPressed: () {
              onSelect(null);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
            ),
            child: Text(
              'مسح المرشح',
              style: TextStyle(
                color: AppTheme.roseRed,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
