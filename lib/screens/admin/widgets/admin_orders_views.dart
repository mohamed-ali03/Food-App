import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/screens/widgets/order_card.dart';

// responsive : done

class AdminOrderTabView extends StatelessWidget {
  final List<OrderModel> orders;
  final List<OrderItemModel> orderItems;

  const AdminOrderTabView({
    required this.orders,
    required this.orderItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockHight * 8),
          child: Text(AppLocalizations.of(context).t('noOrdersYet')),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: SizeConfig.blockHight * 2),
      itemCount: orders.length,
      itemBuilder: (context, index) => OrderCard(
        order: orders[index],
        orderItems: orderItems
            .where((item) => item.orderId == orders[index].orderId)
            .toList(),
      ),
    );
  }
}
