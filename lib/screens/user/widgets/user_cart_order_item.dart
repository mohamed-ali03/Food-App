import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:foodapp/screens/user/widgets/user_cart_quantity_control.dart';
import 'package:provider/provider.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemModel orderItem;
  final Function(int) onChangeQty;
  final Function() onDeleteOrderItem;

  const OrderItemCard({
    super.key,
    required this.orderItem,
    required this.onChangeQty,
    required this.onDeleteOrderItem,
  });

  @override
  Widget build(BuildContext context) {
    final item = context
        .read<MenuProvider>()
        .items
        .where((item) => item.itemId == orderItem.itemId)
        .first;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 1.5),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 1.5,
            vertical: SizeConfig.blockWidth * 1.5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[200]!, width: 1),
            boxShadow: [BoxShadow(color: Colors.grey[100]!, blurRadius: 4)],
          ),
          child: Row(
            children: [
              _CartItemImage(
                imageUrl: item.imageUrl,
                width: SizeConfig.blockHight * 15,
                height: SizeConfig.blockHight * 15,
              ),
              SizedBox(width: SizeConfig.blockWidth * 2),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: SizeConfig.blockHight * 2,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _DeleteButton(onPressed: onDeleteOrderItem),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockHight * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).t(
                            'currency',
                            data: {'amount': item.price.toStringAsFixed(2)},
                          ),
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 1.7,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                        QuantityControl(
                          quantity: orderItem.quantity,
                          onChangeQuantity: onChangeQty,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartItemImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const _CartItemImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
          );
        },
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete_outline, color: Colors.red),
      onPressed: onPressed,
      tooltip: 'Remove item',
      splashRadius: SizeConfig.blockHight * 2,
      constraints: BoxConstraints(
        minWidth: SizeConfig.blockHight * 2,
        minHeight: SizeConfig.blockHight * 2,
      ),
      padding: EdgeInsets.zero,
    );
  }
}
