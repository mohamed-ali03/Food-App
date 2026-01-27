import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/user/widgets/user_home_unsynced_items.dart';
import 'package:foodapp/screens/user/widgets/user_cart_states.dart';
import 'package:foodapp/screens/widgets/order_card.dart';
import 'package:provider/provider.dart';

// responsive : done

class UserCartScreen extends StatefulWidget {
  const UserCartScreen({super.key});

  @override
  State<UserCartScreen> createState() => _UserCartScreenState();
}

class _UserCartScreenState extends State<UserCartScreen>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('myOrders')),
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
                  Icon(Icons.shopping_cart, size: SizeConfig.blockWidth * 5),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('cart')),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, size: SizeConfig.blockWidth * 5),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('processing')),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: SizeConfig.blockWidth * 5),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('delivered')),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.isLoading && orderProvider.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final unorderedItems = orderProvider.orderItems
            .where((item) => item.synced == false)
            .toList();
        final processingOrders = orderProvider.orders
            .where(
              (order) =>
                  order.status.toLowerCase() != 'delivered' &&
                  order.status.toLowerCase() != 'canceled',
            )
            .toList();
        final deliveredOrders = orderProvider.orders
            .where(
              (order) =>
                  order.status.toLowerCase() == 'delivered' ||
                  order.status.toLowerCase() == 'canceled',
            )
            .toList();

        return TabBarView(
          controller: tabController,
          children: [
            _CartTabView(orderItems: unorderedItems),
            _OrdersTabView(
              orders: processingOrders,
              orderItems: orderProvider.orderItems,
            ),
            _OrdersTabView(
              orders: deliveredOrders,
              orderItems: orderProvider.orderItems,
            ),
          ],
        );
      },
    );
  }
}

class _CartTabView extends StatelessWidget {
  final List<OrderItemModel> orderItems;

  const _CartTabView({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return orderItems.isEmpty
        ? EmptyCartState()
        : UnsyncedItems(orderItems: orderItems);
  }
}

class _OrdersTabView extends StatelessWidget {
  final List<OrderModel> orders;
  final List<OrderItemModel> orderItems;

  const _OrdersTabView({required this.orders, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return EmptyOrdersState();
    }

    final sortedOrders = List<OrderModel>.from(orders)
      ..sort((a, b) {
        final aTime = a.createdAt ?? DateTime(1970);
        final bTime = b.createdAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });

    return ListView.builder(
      padding: EdgeInsets.all(SizeConfig.blockHight),
      itemCount: sortedOrders.length,
      itemBuilder: (context, index) => OrderCard(
        order: sortedOrders[index],
        orderItems: orderItems
            .where(
              (orderItem) => orderItem.localOrderId == sortedOrders[index].id,
            )
            .toList(),
      ),
    );
  }
}
