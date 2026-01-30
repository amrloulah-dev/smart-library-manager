import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RiskyBookCard extends StatelessWidget {
  final String title;
  final int currentStock;
  final int suggestedReturn;
  final bool isSelected;
  final VoidCallback onTap;

  const RiskyBookCard({
    super.key,
    required this.title,
    required this.currentStock,
    required this.suggestedReturn,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B), // Dark Slate
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? Border.all(color: const Color(0xFF3B82F6), width: 1.5)
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selection Checkbox (Right in RTL)
            _buildCheckbox(),
            SizedBox(width: 16.w),

            // Content (Center)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Alert Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'مرتفع جداً',
                          style: TextStyle(
                            color: const Color(0xFFEF4444), // Red/Pink
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Stats Row
                  Row(
                    children: [
                      // Stock
                      _buildStatItem(
                        icon: Icons.inventory_2_outlined,
                        label: 'المخزون:',
                        value: '$currentStock',
                        color: Colors.white60,
                      ),
                      SizedBox(width: 16.w),
                      // Suggested Return
                      _buildStatItem(
                        icon: Icons.undo_rounded,
                        label: 'مقترح:',
                        value: '$suggestedReturn',
                        color: const Color(0xFF3B82F6), // Blue
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
        border: isSelected ? null : Border.all(color: Colors.white24, width: 2),
      ),
      child: isSelected
          ? Icon(Icons.check, color: Colors.white, size: 16.sp)
          : null,
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.sp,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
