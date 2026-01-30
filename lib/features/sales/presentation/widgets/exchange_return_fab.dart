import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:librarymanager/features/sales/presentation/widgets/managers/fab_cubit.dart';

/// Expandable FAB (Speed Dial) for Exchange and Return actions
/// Shows two options when expanded: Return Book and Exchange Book
class ExchangeReturnFab extends StatefulWidget {
  final VoidCallback? onReturnTap;
  final VoidCallback? onExchangeTap;

  const ExchangeReturnFab({super.key, this.onReturnTap, this.onExchangeTap});

  @override
  State<ExchangeReturnFab> createState() => _ExchangeReturnFabState();
}

class _ExchangeReturnFabState extends State<ExchangeReturnFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(
          begin: 0.0,
          end: 0.375, // 135 degrees (3/8 of a full rotation)
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleOptionTap(
    BuildContext context,
    VoidCallback? callback,
    String action,
  ) {
    // Close the FAB
    context.read<FabCubit>().collapse();

    // Wait for animation to complete then execute callback
    Future.delayed(const Duration(milliseconds: 200), () {
      callback?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FabCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<FabCubit, bool>(
            listener: (context, isExpanded) {
              if (isExpanded) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
            child: BlocBuilder<FabCubit, bool>(
              builder: (context, isExpanded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expanded Options
                    if (isExpanded) ...[
                      // Return Book Option
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _scaleAnimation,
                          child: _buildOption(
                            icon: Icons.keyboard_return,
                            label: 'ارجاع كتاب',
                            onTap: () => _handleOptionTap(
                              context,
                              widget.onReturnTap,
                              'Return',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Exchange Book Option
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _scaleAnimation,
                          child: _buildOption(
                            icon: Icons.swap_horiz,
                            label: 'استبدال كتاب',
                            onTap: () => _handleOptionTap(
                              context,
                              widget.onExchangeTap,
                              'Exchange',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Main Toggle Button
                    SizedBox(
                      width: 65.w,
                      height: 65.w,
                      child: FloatingActionButton(
                        heroTag: 'exchange_return_fab',
                        onPressed: () => context.read<FabCubit>().toggle(),
                        backgroundColor: const Color(
                          0xFF3B82F6,
                        ), // Electric Blue
                        elevation: 6,
                        shape: const CircleBorder(),
                        child: AnimatedBuilder(
                          animation: _rotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value * 2 * 3.14159,
                              child: Icon(
                                isExpanded ? Icons.close : Icons.add,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2439), // Dark Slate
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Mini FAB
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6), // Electric Blue
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24.sp),
          ),
        ],
      ),
    );
  }
}
