import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/features/auth/presentation/manager/auth_cubit.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Notification & Refresh Buttons

        // User Profile
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'مرحباً بك،',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String libraryName = 'أحمد';
                    if (state is Authenticated) {
                      libraryName =
                          state.user.userMetadata?['library_name'] ?? 'أحمد';
                    }
                    return Text(
                      libraryName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(width: 12.w),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color(0xFF1E2439),
              // backgroundImage: const AssetImage('assets/images/user_avatar.png'), // Removed missing asset
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2439),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }
}
