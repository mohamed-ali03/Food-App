import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/admin/widgets/admin_order_states.dart';
import 'package:foodapp/screens/admin/widgets/admin_orders_stats.dart';
import 'package:foodapp/screens/admin/widgets/admin_orders_views.dart';
import 'package:provider/provider.dart';

// reaponsive : done

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Map<String, int> _calculateStats(List<OrderModel> orders) {
    return {
      'pending': orders
          .where((o) => o.status.toLowerCase() == 'pending')
          .length,
      'processing': orders
          .where(
            (o) =>
                o.status.toLowerCase() != 'pending' &&
                o.status.toLowerCase() != 'delivered',
          )
          .length,
      'delivered': orders
          .where((o) => o.status.toLowerCase() == 'delivered')
          .length,
      'total': orders.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('orderManagement')),
        elevation: 0,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pending, size: SizeConfig.blockHight * 2.8),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('pending')),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, size: SizeConfig.blockHight * 2.8),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('processing')),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: SizeConfig.blockHight * 2.8),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('delivered')),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
        child: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            if (orderProvider.isLoading && orderProvider.orders.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (orderProvider.error != null) {
              return AdminOrdersErrorState(
                error: orderProvider.error!,
                onRetry: () => orderProvider.fetchAllOrders(),
              );
            }

            final sortedOrders = List<OrderModel>.from(orderProvider.orders)
              ..sort((a, b) => (b.orderId ?? 0).compareTo(a.orderId ?? 0));

            final stats = _calculateStats(sortedOrders);

            return Column(
              children: [
                // Stats Section
                AdminOrdersStats(stats: stats),

                SizedBox(height: SizeConfig.blockHight * 2),

                // Orders List
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      AdminOrderTabView(
                        orders: sortedOrders
                            .where(
                              (order) =>
                                  order.status.toLowerCase() == 'pending',
                            )
                            .toList(),
                        orderItems: orderProvider.orderItems,
                      ),
                      AdminOrderTabView(
                        orders: sortedOrders
                            .where(
                              (order) =>
                                  order.status.toLowerCase() != 'pending' &&
                                  order.status.toLowerCase() != 'delivered' &&
                                  order.status.toLowerCase() != 'canceled',
                            )
                            .toList(),
                        orderItems: orderProvider.orderItems,
                      ),
                      AdminOrderTabView(
                        orders: sortedOrders
                            .where(
                              (order) =>
                                  order.status.toLowerCase() == 'delivered' ||
                                  order.status.toLowerCase() == 'canceled',
                            )
                            .toList(),
                        orderItems: orderProvider.orderItems,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
