import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarymanager/features/auth/presentation/manager/auth_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class LicenseExpiredScreen extends StatelessWidget {
  const LicenseExpiredScreen({super.key});

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse(
      'https://wa.me/201012345678',
    ); // Dynamic support number
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    String expiryDateText = 'غير محدد';

    if (state is AuthLicenseExpired && state.expiryDate != null) {
      expiryDateText = intl.DateFormat('yyyy/MM/dd').format(state.expiryDate!);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // Dark Navy
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_clock, size: 100, color: Colors.redAccent),
              const SizedBox(height: 32),
              Text(
                'انتهت فترة الترخيص',
                style: GoogleFonts.cairo(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'انتهت صلاحية نسختك بتاريخ $expiryDateText.\nيرجى التواصل مع الدعم الفني للتجديد.',
                style: GoogleFonts.cairo(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                icon: const Icon(Icons.message),
                label: Text(
                  'تواصل واتساب للتجديد',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: Text(
                  'تسجيل الخروج',
                  style: GoogleFonts.cairo(color: Colors.white54, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
