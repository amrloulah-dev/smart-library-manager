import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatusRingsWidget extends StatelessWidget {
  final int returnsCount;
  final int lowStockCount;
  final int debtsCount;

  const StatusRingsWidget({
    super.key,
    required this.returnsCount,
    required this.lowStockCount,
    required this.debtsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Returns Ring
        _StatusRing(
          color: Colors.red,
          count: returnsCount,
          icon: Icons.assignment_return,
          label: 'Returns',
          onTap: () => context.push('/inventory/supplier_return'),
        ),
        // Low Stock Ring
        _StatusRing(
          color: Colors.blue,
          count: lowStockCount,
          icon: Icons.inventory_2,
          label: 'مخزون منخفض',
          onTap: () => context.push('/shortages'),
        ),
        // Debts/Collection Ring
        _StatusRing(
          color: Colors.green,
          count: debtsCount,
          icon: Icons.attach_money,
          label: 'Debts',
          onTap: () => context.push('/sales_details'),
        ),
      ],
    );
  }
}

class _StatusRing extends StatelessWidget {
  final Color color;
  final int count;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StatusRing({
    required this.color,
    required this.count,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: count > 0 ? color : Colors.grey.withOpacity(0.3),
                width: 3,
              ),
              color: color.withOpacity(0.1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 30, color: count > 0 ? color : Colors.grey),
                if (count > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: count > 0 ? color : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
