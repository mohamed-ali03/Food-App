import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20model/order_model.dart';

// responsive : done

class RecentActivityCard extends StatelessWidget {
  final List<OrderModel> orders;

  const RecentActivityCard({super.key, required this.orders});

  List<OrderModel> _getRecentOrders() {
    final sorted = List<OrderModel>.from(orders)
      ..sort((a, b) {
        final aTime = a.createdAt ?? DateTime(1970);
        final bTime = b.createdAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });
    return sorted.take(5).toList();
  }

  String _formatTimeAgo(BuildContext context, DateTime? date) {
    if (date == null) return AppLocalizations.of(context).t('unknown');
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? AppLocalizations.of(context).t('day') : AppLocalizations.of(context).t('days')}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? AppLocalizations.of(context).t('hour') : AppLocalizations.of(context).t('hours')}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? AppLocalizations.of(context).t('minute') : AppLocalizations.of(context).t('minutes')}';
    } else {
      return AppLocalizations.of(context).t('just_now');
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'processing':
        return Icons.restaurant;
      case 'completed':
      case 'delivered':
        return Icons.check_circle;
      default:
        return Icons.notifications;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentOrders = _getRecentOrders();

    if (recentOrders.isEmpty) {
      return Container(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2.5),
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
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.inbox,
                size: SizeConfig.blockHight * 7,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context).t('noRecentActivity'),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: SizeConfig.blockHight * 2,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(SizeConfig.blockHight * 2.5),
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
      child: Column(
        children: [
          ...recentOrders.asMap().entries.map((entry) {
            final index = entry.key;
            final order = entry.value;
            return Column(
              children: [
                _ActivityItem(
                  icon: _getStatusIcon(order.status),
                  title:
                      '${AppLocalizations.of(context).t('order', data: {'orderId': order.orderId.toString()})} - ${AppLocalizations.of(context).t(order.status).toUpperCase()}',
                  time: _formatTimeAgo(context, order.createdAt),
                  color: _getStatusColor(order.status),
                ),
                if (index < recentOrders.length - 1) const Divider(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockWidth * 2),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: SizeConfig.blockHight * 3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 1.8,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
