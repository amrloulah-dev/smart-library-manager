import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:librarymanager/core/theme/app_theme.dart';
import 'package:librarymanager/core/utils/responsive_layout.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      tablet: _buildDesktopLayout(context), // Shared for Tablet/Desktop
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final activeIndex = navigationShell.currentIndex;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.quietDark,
        padding: EdgeInsets.zero,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              0,
              Icons.home_filled,
              Icons.home_outlined,
              'الرئيسية',
              activeIndex,
            ),
            _buildNavItem(
              context,
              1,
              Icons.inventory_2,
              Icons.inventory_2_outlined,
              'المخزن',
              activeIndex,
            ),
            _buildNavItem(
              context,
              2,
              Icons.point_of_sale,
              Icons.point_of_sale,
              'كاشير',
              activeIndex,
            ),
            _buildNavItem(
              context,
              3,
              Icons.people,
              Icons.people_outline,
              'العلاقات',
              activeIndex,
            ),
            _buildNavItem(
              context,
              4,
              Icons.bar_chart,
              Icons.bar_chart_outlined,
              'التقارير',
              activeIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final activeIndex = navigationShell.currentIndex;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: AppTheme.quietDark,
            selectedIndex: activeIndex,
            onDestinationSelected: (index) => _onItemTapped(index, context),
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelTextStyle: const TextStyle(
              color: AppTheme.softGrey,
              fontSize: 11,
            ),
            selectedIconTheme: const IconThemeData(color: AppTheme.primaryBlue),
            unselectedIconTheme: const IconThemeData(color: AppTheme.softGrey),
            useIndicator: true,
            indicatorColor: AppTheme.primaryBlue.withOpacity(0.1),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('الرئيسية'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2),
                label: Text('المخزن'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.point_of_sale),
                selectedIcon: Icon(Icons.point_of_sale),
                label: Text('كاشير'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('العلاقات'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: Text('التقارير'),
              ),
            ],
          ),
          const VerticalDivider(width: 1, color: Color(0xFF1E2439)),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
    int activeIndex,
  ) {
    final isSelected = activeIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index, context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? AppTheme.primaryBlue : AppTheme.softGrey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryBlue : AppTheme.softGrey,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
