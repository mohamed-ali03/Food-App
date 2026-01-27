import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// responsive : done

class AdminQuickActionsGrid extends StatelessWidget {
  final BuildContext parentContext;

  const AdminQuickActionsGrid({required this.parentContext, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: SizeConfig.blockWidth * 3,
      mainAxisSpacing: SizeConfig.blockHight * 3,
      childAspectRatio: 2,
      children: [
        _QuickActionCard(
          title: AppLocalizations.of(context).t('manageMenu'),
          icon: Icons.restaurant_menu,
          color: Colors.blue,
          onTap: () => Navigator.pushNamed(parentContext, '/adminMenuScreen'),
        ),
        _QuickActionCard(
          title: AppLocalizations.of(context).t('viewOrders'),
          icon: Icons.list_alt,
          color: Colors.green,
          onTap: () => Navigator.pushNamed(parentContext, '/adminOrdersScreen'),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: SizeConfig.blockHight * 3.5),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 2.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: SizeConfig.blockHight * 2,
            ),
          ],
        ),
      ),
    );
  }
}
