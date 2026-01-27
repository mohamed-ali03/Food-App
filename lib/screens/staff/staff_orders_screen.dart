import 'package:flutter/material.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/admin/widgets/admin_orders_views.dart';
import 'package:provider/provider.dart';

// responsive : done

class StaffOrdersScreen extends StatelessWidget {
  const StaffOrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).t('orders'))),
      body: Consumer<OrderProvider>(
        builder: (context, orderProv, _) {
          if (orderProv.isLoading && orderProv.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = orderProv.orders
              .where(
                (o) =>
                    o.status.toLowerCase() != 'delivered' &&
                    o.status.toLowerCase() != 'canceled',
              )
              .toList();

          if (orders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 24),
                    Text(AppLocalizations.of(context).t('noActiveOrders')),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => orderProv.fetchAllOrders(),
                      child: Text(AppLocalizations.of(context).t('refresh')),
                    ),
                  ],
                ),
              ),
            );
          }

          return AdminOrderTabView(
            orders: orders,
            orderItems: orderProv.orderItems,
          );
        },
      ),
    );
  }
}
