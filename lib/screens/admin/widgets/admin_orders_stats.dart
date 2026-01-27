import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// responsive : done

class AdminOrdersStats extends StatelessWidget {
  final Map<String, int> stats;

  const AdminOrdersStats({required this.stats, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockHight * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: AppLocalizations.of(context).t('total'),
            value: stats['total']!.toString(),
            icon: Icons.receipt_long,
            color: Colors.blue,
          ),
          _StatItem(
            label: AppLocalizations.of(context).t('pending'),
            value: stats['pending']!.toString(),
            icon: Icons.pending,
            color: Colors.orange,
          ),
          _StatItem(
            label: AppLocalizations.of(context).t('processing'),
            value: stats['processing']!.toString(),
            icon: Icons.restaurant,
            color: Colors.blue,
          ),
          _StatItem(
            label: AppLocalizations.of(context).t('delivered'),
            value: stats['delivered']!.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: SizeConfig.blockHight * 4),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: SizeConfig.blockHight * 3,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.blockHight * 1.8,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
