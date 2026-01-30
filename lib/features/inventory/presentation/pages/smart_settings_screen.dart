import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/widgets/custom_loading_indicator.dart';
import 'package:librarymanager/features/inventory/presentation/manager/smart_settings_cubit.dart';

class SmartSettingsScreen extends StatelessWidget {
  const SmartSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SmartSettingsCubit>()..loadSettings(),
      child: const _SmartSettingsScreenContent(),
    );
  }
}

class _SmartSettingsScreenContent extends StatefulWidget {
  const _SmartSettingsScreenContent();

  @override
  State<_SmartSettingsScreenContent> createState() =>
      _SmartSettingsScreenContentState();
}

class _SmartSettingsScreenContentState
    extends State<_SmartSettingsScreenContent> {
  DateTime? _seasonEndDate;
  final Map<String, TextEditingController> _controllers = {};

  final List<String> _grades = [
    '1ب',
    '2ب',
    '3ب',
    '4ب',
    '5ب',
    '6ب',
    '1ع',
    '2ع',
    '3ع',
    '1ث',
    '2ث',
    '3ث',
  ];

  @override
  void initState() {
    super.initState();
    for (var grade in _grades) {
      _controllers[grade] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onSave(BuildContext context) {
    final Map<String, int> targets = {};
    _controllers.forEach((grade, controller) {
      if (controller.text.isNotEmpty) {
        final val = int.tryParse(controller.text);
        if (val != null) {
          targets[grade] = val;
        }
      }
    });

    context.read<SmartSettingsCubit>().saveSettings(
      seasonEndDate: _seasonEndDate,
      gradeTargets: targets,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ الإعدادات بنجاح'),
        backgroundColor: Colors.green,
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Deep Navy from spec
      appBar: AppBar(
        title: const Text(
          'إعدادات الذكاء الاصطناعي',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<SmartSettingsCubit, SmartSettingsState>(
        listener: (context, state) {
          if (state is SmartSettingsLoaded) {
            if (state.seasonEndDate != null) {
              _seasonEndDate = state.seasonEndDate;
            }
            state.gradeTargets.forEach((grade, target) {
              if (_controllers.containsKey(grade)) {
                _controllers[grade]!.text = target.toString();
              }
            });
          }
        },
        builder: (context, state) {
          if (state is SmartSettingsLoading) {
            return const Center(child: CustomLoadingIndicator());
          }

          if (state is SmartSettingsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section 1: Season Setup
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_buildSectionTitle('إعدادات الموسم')],
                ),
                SizedBox(height: 12.h),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate:
                          _seasonEndDate ??
                          DateTime.now().add(const Duration(days: 90)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365 * 2),
                      ),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF3B82F6), // Blue/Cyan accent
                              onPrimary: Colors.white,
                              surface: Color(0xFF1E2439),
                              onSurface: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (date != null) {
                      setState(() {
                        _seasonEndDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2439), // Dark Slate
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: const Color(0xFF3B82F6), // Blue
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تاريخ نهاية الموسم',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Text(
                              _seasonEndDate == null
                                  ? 'اختر التاريخ'
                                  : DateFormat(
                                      'dd MMM yyyy',
                                      'ar',
                                    ).format(_seasonEndDate!),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // Section 2: Market Capacity with Grid
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildSectionTitle('أعداد الطلاب المتوقعة'),
                    Text(
                      'اترك الخانة فارغة إذا كنت لا تعرف العدد',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: _grades.length,
                  itemBuilder: (context, index) {
                    final grade = _grades[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getGradeLabel(grade),
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _controllers[grade],
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Cairo',
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(
                                0xFF111625,
                              ), // Even darker for input
                              hintText: '0',
                              hintStyle: const TextStyle(
                                color: Colors.white24,
                                fontFamily: 'Cairo',
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3B82F6), // Blue focus
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 40.h),

                // Button
                ElevatedButton(
                  onPressed: () => _onSave(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6), // Blue/Cyan
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.psychology, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        'حفظ وتفعيل الذكاء الاصطناعي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    );
  }

  String _getGradeLabel(String code) {
    const map = {
      '1ب': '1 ابتدائي',
      '2ب': '2 ابتدائي',
      '3ب': '3 ابتدائي',
      '4ب': '4 ابتدائي',
      '5ب': '5 ابتدائي',
      '6ب': '6 ابتدائي',
      '1ع': '1 إعدادي',
      '2ع': '2 إعدادي',
      '3ع': '3 إعدادي',
      '1ث': '1 ثانوي',
      '2ث': '2 ثانوي',
      '3ث': '3 ثانوي',
    };
    return map[code] ?? code;
  }
}
