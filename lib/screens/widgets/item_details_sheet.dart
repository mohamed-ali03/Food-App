import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/screens/widgets/availability_badge.dart';
import 'package:provider/provider.dart';

// Responsive : done

void showItemDetails(
  BuildContext context, {
  required ItemModel item,
  required String categoryName,
  ValueChanged<bool>? onSelectItem,
  VoidCallback? onEdit,
  bool needButton = true,
}) {
  final rawIngredients = (item.ingreidents).trim();
  final ingredients = rawIngredients.isEmpty
      ? <String>[]
      : rawIngredients
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      final role = context.read<AuthProvider>().user?.role ?? 'user';
      return ItemDetailsSheet(
        item: item,
        categoryName: categoryName,
        onSelectItem: onSelectItem,
        onEdit: onEdit,
        ingredients: ingredients,
        role: role,
        needButton: needButton,
      );
    },
  );
}

class ItemDetailsSheet extends StatefulWidget {
  final ItemModel item;
  final String categoryName;
  final String role;
  final List<String> ingredients;
  final ValueChanged<bool>? onSelectItem;
  final VoidCallback? onEdit;
  final bool needButton;

  const ItemDetailsSheet({
    super.key,
    required this.item,
    required this.role,
    required this.ingredients,
    required this.categoryName,
    this.onSelectItem,
    this.onEdit,
    this.needButton = true,
  });

  @override
  State<ItemDetailsSheet> createState() => _ItemDetailsSheetState();
}

class _ItemDetailsSheetState extends State<ItemDetailsSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 3,
          vertical: SizeConfig.blockHight * 1,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.item.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          size: SizeConfig.blockHight * 8,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: SizeConfig.blockHight * 2),
              Text(
                widget.item.name,
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.blockHight * 2),
              AvailabilityBadge(available: widget.item.available),
              SizedBox(height: SizeConfig.blockHight * 2),
              Text(
                AppLocalizations.of(context).t('description'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.blockHight * 2,
                ),
              ),
              SizedBox(height: SizeConfig.blockHight),

              Text(
                widget.item.description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: SizeConfig.blockHight * 2),

              if (widget.ingredients.isNotEmpty) ...[
                Text(
                  AppLocalizations.of(context).t('ingredients'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockHight * 2,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHight),
                Wrap(
                  spacing: SizeConfig.blockWidth * 2,
                  runSpacing: SizeConfig.blockWidth * 2,
                  children: widget.ingredients
                      .map(
                        (ing) => Chip(
                          label: Text(
                            ing,
                            style: TextStyle(
                              fontSize: SizeConfig.blockHight * 1.5,
                            ),
                          ),
                          backgroundColor: Colors.grey[100],
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: SizeConfig.blockHight * 2),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).t(
                      'currency',
                      data: {'amount': widget.item.price.toStringAsFixed(2)},
                    ),
                    style: TextStyle(
                      fontSize: SizeConfig.blockHight * 2.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: SizeConfig.blockHight * 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockHight * 2),
              if (widget.needButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: widget.role == 'user'
                          ? ElevatedButton.icon(
                              onPressed: widget.item.available
                                  ? () {
                                      widget.onSelectItem?.call(true);
                                      Navigator.pop(context);
                                    }
                                  : null,
                              icon: const Icon(Icons.add_shopping_cart),
                              label: Text(
                                AppLocalizations.of(context).t('addToCart'),
                              ),
                            )
                          : OutlinedButton.icon(
                              onPressed: widget.onEdit,
                              icon: const Icon(Icons.edit),
                              label: Text(
                                AppLocalizations.of(context).t('edit'),
                              ),
                            ),
                    ),
                    if (widget.role == 'user')
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppLocalizations.of(context).t('cancel')),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: SizeConfig.blockHight * 2),
            ],
          ),
        ),
      ),
    );
  }
}
