import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/widgets/availability_badge.dart';
import 'package:foodapp/screens/widgets/item_details_sheet.dart';
import 'package:provider/provider.dart';

// Responsive : done

class ItemCard extends StatefulWidget {
  final ItemModel item;
  final String categoryName;
  final ValueChanged<bool>? onSelectItem; // for user mode
  final VoidCallback? onEdit; // for admin/staff

  const ItemCard({
    super.key,
    required this.item,
    required this.categoryName,
    this.onSelectItem,
    this.onEdit,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final role = context.read<AuthProvider>().user?.role ?? 'user';

    return Card(
      margin: EdgeInsets.only(bottom: SizeConfig.blockHight * 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showItemDetails(
          context,
          item: widget.item,
          categoryName: widget.categoryName,
          onSelectItem: widget.onSelectItem,
          onEdit: widget.onEdit,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.blockHight * 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imageUrl,
                      width: SizeConfig.blockWidth * 25,
                      height: SizeConfig.blockWidth * 25,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => Container(
                        width: SizeConfig.blockWidth * 25,
                        height: SizeConfig.blockWidth * 25,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockHight * 2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.blockHight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.categoryName,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: SizeConfig.blockHight * 1.7,
                                  ),
                                ),
                                SizedBox(height: SizeConfig.blockHight),
                                Text(
                                  AppLocalizations.of(context).t(
                                    'currency',
                                    data: {
                                      'amount': widget.item.price
                                          .toStringAsFixed(2),
                                    },
                                  ),
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.blockHight * 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: SizeConfig.blockWidth),
                            AvailabilityBadge(available: widget.item.available),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: role == 'user'
                    ? [
                        Text(
                          '${AppLocalizations.of(context).t('price')}: ${AppLocalizations.of(context).t("currency", data: {'amount': widget.item.price.toStringAsFixed(2)})}',
                          style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                        ),
                        widget.item.available
                            ? Selector<OrderProvider, bool>(
                                selector: (_, provider) =>
                                    provider.orderItems.any(
                                      (o) =>
                                          o.itemId == widget.item.itemId &&
                                          o.synced == false,
                                    ),
                                builder: (context, isSelected, child) {
                                  if (!widget.item.available) {
                                    return const Icon(
                                      Icons.block,
                                      color: Colors.red,
                                    );
                                  }

                                  return IconButton(
                                    icon: Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.add_shopping_cart,
                                      color: isSelected ? Colors.green : null,
                                    ),
                                    onPressed: () {
                                      widget.onSelectItem?.call(!isSelected);
                                    },
                                  );
                                },
                              )
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.block,
                                  color: Colors.red,
                                ),
                              ),
                      ]
                    : [
                        if (widget.onEdit != null)
                          TextButton.icon(
                            onPressed: widget.onEdit,
                            icon: Icon(
                              Icons.edit,
                              size: SizeConfig.blockHight * 3,
                            ),
                            label: Text(AppLocalizations.of(context).t('edit')),
                          ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
