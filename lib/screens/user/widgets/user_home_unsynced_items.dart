import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/user/widgets/user_cart_order_item.dart';
import 'package:provider/provider.dart';

// responsive : done

// ignore: must_be_immutable
class UnsyncedItems extends StatefulWidget {
  List<OrderItemModel> orderItems;

  UnsyncedItems({super.key, required this.orderItems});

  @override
  State<UnsyncedItems> createState() => _UnsyncedItemsState();
}

class _UnsyncedItemsState extends State<UnsyncedItems> {
  final ValueNotifier<double> totalPrice = ValueNotifier<double>(0);
  final addressController = TextEditingController();
  late OrderProvider orderProvider;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    orderProvider = context.read<OrderProvider>();
    _calculateTotal();
  }

  @override
  void dispose() {
    // Only update if there are items left and changes were made
    if (isChanged) {
      orderProvider.updateOrderItemsLocally(widget.orderItems);
    }
    totalPrice.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    double temp = 0;
    for (final item in widget.orderItems) {
      temp += item.price * item.quantity;
    }
    totalPrice.value = temp;
  }

  Future<void> _confirmDeleteItem(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          AppLocalizations.of(context).t('deleteItem'),
          style: TextStyle(fontSize: SizeConfig.blockHight * 3),
        ),

        content: Text(
          AppLocalizations.of(context).t('deleteItemConfirm'),
          style: TextStyle(fontSize: SizeConfig.blockHight * 1.8),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text(AppLocalizations.of(context).t('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text(
              AppLocalizations.of(context).t('delete'),
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (shouldDelete == true) {
      int id = widget.orderItems[index].id;
      widget.orderItems.removeAt(index);
      await orderProvider.deleteOrderItemLocally(id: id);
      _calculateTotal();
    }
  }

  void _onDeleteItem(int index) => _confirmDeleteItem(index);

  Future<void> _handleCheckout() async {
    final authProvider = context.read<AuthProvider>();
    final orderprovider = context.read<OrderProvider>();

    if (authProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).t('pleaseLoginToContinue'),
          ),
        ),
      );
      return;
    }

    if (widget.orderItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).t('noItemsToCheckout')),
        ),
      );
      return;
    }

    // Show dialog that returns the entered address (or null if cancelled).
    if (authProvider.user?.address != null) {
      addressController.text = authProvider.user!.address!;
    }

    final address = await showDialog<String?>(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).t('checkout')),
          titleTextStyle: TextStyle(
            fontSize: SizeConfig.blockHight * 3,
            color: Colors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).t('confirmCheckout'),
                style: TextStyle(fontSize: SizeConfig.blockHight * 1.8),
              ),
              SizedBox(height: SizeConfig.blockHight * 2),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).t('deliveryAddress'),
                  labelStyle: TextStyle(fontSize: SizeConfig.blockHight * 1.8),
                  hintStyle: TextStyle(fontSize: SizeConfig.blockHight * 1.8),
                  hintText: AppLocalizations.of(
                    context,
                  ).t('enterDeliveryAddress'),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, null),
              child: Text(AppLocalizations.of(context).t('cancel')),
            ),
            TextButton(
              onPressed: () {
                final value = addressController.text.trim();
                addressController.clear();
                Navigator.pop(c, value.isEmpty ? null : value);
              },
              child: Text(
                AppLocalizations.of(context).t('confirm'),
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );

    // If user cancelled or provided no address, stop
    if (address == null || address.isEmpty) {
      if (mounted && (address == null)) {
        // cancelled - do nothing
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).t('pleaseProvideADeliveryAddress'),
            ),
          ),
        );
      }
      return;
    }

    final order = OrderModel()
      ..address = address
      ..status = 'pending'
      ..totalPrice = totalPrice.value
      ..userId = authProvider.user!.authID;

    await orderprovider.placeOrder(order, widget.orderItems);
  }

  @override
  Widget build(BuildContext context) {
    _calculateTotal();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHight),
            itemCount: widget.orderItems.length,
            separatorBuilder: (_, _) => SizedBox(height: SizeConfig.blockHight),
            itemBuilder: (context, index) {
              final orderItem = widget.orderItems[index];
              return OrderItemCard(
                orderItem: orderItem,
                onChangeQty: (qty) {
                  orderItem.quantity = qty;
                  isChanged = true;
                  _calculateTotal();
                },
                onDeleteOrderItem: () => _onDeleteItem(index),
              );
            },
          ),
        ),
        _buildCheckoutSection(),
      ],
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockHight * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).t('orderSummary'),
            style: TextStyle(
              fontSize: SizeConfig.blockHight * 2,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SizeConfig.blockHight * 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ValueListenableBuilder<double>(
                  valueListenable: totalPrice,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).t('countOfItems')} ${widget.orderItems.length.toString()} ',
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 1.5,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHight),
                        Text(
                          AppLocalizations.of(context).t('total'),
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHight),
                        Text(
                          AppLocalizations.of(context).t(
                            'currency',
                            data: {'amount': value.toStringAsFixed(2)},
                          ),
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: widget.orderItems.isEmpty ? null : _handleCheckout,
                icon: const Icon(Icons.shopping_bag_outlined),
                label: Text(AppLocalizations.of(context).t('checkout')),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockHight * 3,
                    vertical: SizeConfig.blockHight * 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
