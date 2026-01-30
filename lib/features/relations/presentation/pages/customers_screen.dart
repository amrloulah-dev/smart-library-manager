import 'package:flutter/material.dart';
import 'package:librarymanager/core/theme/app_theme.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العلاقات (العملاء)'),
        backgroundColor: AppTheme.quietDark,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 80, color: AppTheme.primaryBlue),
            SizedBox(height: 20),
            Text(
              'قريباً: إدارة العملاء والذمم',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
