import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/functions.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:provider/provider.dart';

// responsive : done

class MenuItemFormDialog extends StatefulWidget {
  final bool isEdit;
  final ItemModel? initialItem;
  final Function(
    String name,
    double price,
    String description,
    int categoryId,
    bool available,
    String imageUrl,
    String ingreidents,
  )
  onSave;

  const MenuItemFormDialog({
    super.key,
    this.isEdit = false,
    this.initialItem,
    required this.onSave,
  });

  @override
  State<MenuItemFormDialog> createState() => _MenuItemFormDialogState();
}

class _MenuItemFormDialogState extends State<MenuItemFormDialog> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController ingreidentsController;
  ValueNotifier<bool> isAvailable = ValueNotifier(true);
  ValueNotifier<int> selectedCategoryId = ValueNotifier(1);
  ValueNotifier<String?> imageUrl = ValueNotifier(null);
  ValueNotifier<bool> isUploadingImage = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  UploadImage uploadImage = UploadImage();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.initialItem?.name ?? '',
    );
    priceController = TextEditingController(
      text: widget.initialItem?.price.toString() ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.initialItem?.description ?? '',
    );
    ingreidentsController = TextEditingController(
      text: widget.initialItem?.ingreidents ?? '',
    );
    isAvailable.value = widget.initialItem?.available ?? true;
    selectedCategoryId.value = widget.initialItem?.categoryId ?? 1;
    imageUrl.value = widget.initialItem?.imageUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    ingreidentsController.dispose();
    super.dispose();
  }

  void _handleImageUpload() async {
    isUploadingImage.value = true;
    final messager = ScaffoldMessenger.of(context);
    final appLocal = AppLocalizations.of(context);

    final file = await uploadImage.pickImage();
    if (file == null) {
      messager.showSnackBar(
        SnackBar(content: Text(appLocal.t('failedToPickImage'))),
      );
      isUploadingImage.value = false;
      return;
    }

    imageUrl.value = await uploadImage.uploadImage('item_pic', file);

    if (imageUrl.value!.isEmpty) {
      messager.showSnackBar(
        SnackBar(content: Text(appLocal.t('failedToUploadImage'))),
      );
      isUploadingImage.value = false;
      return;
    }
    isUploadingImage.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.isEdit
            ? AppLocalizations.of(context).t('editMenuItem')
            : AppLocalizations.of(context).t('addMenuItem'),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Upload Section
              Container(
                width: double.infinity,
                height: SizeConfig.blockHight * 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: ValueListenableBuilder(
                  valueListenable: imageUrl,
                  builder: (context, valueImg, child) {
                    return valueImg != null && valueImg.isNotEmpty
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: valueImg,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () => imageUrl.value = null,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ValueListenableBuilder(
                            valueListenable: isUploadingImage,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: value ? null : _handleImageUpload,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (value)
                                      const CircularProgressIndicator()
                                    else ...[
                                      Icon(
                                        Icons.image_outlined,
                                        size: 48,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        ).t('tapToUploadImage'),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).t('itemName'),
                  hintText: AppLocalizations.of(
                    context,
                  ).t('e.g., Margherita Pizza'),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(
                      context,
                    ).t('pleaseEnterItemName');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).t('price'),
                  hintText: AppLocalizations.of(context).t('e.g., 12.99'),
                  suffixText: AppLocalizations.of(context).t('egp'),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).t('pleaseEnterPrice');
                  }
                  if (double.tryParse(value) == null) {
                    return AppLocalizations.of(
                      context,
                    ).t('pleaseEnterValidPrice');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).t('description'),
                  hintText: AppLocalizations.of(context).t('itemDescription'),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(
                      context,
                    ).t('pleaseEnterDescription');
                  }
                  if (value.trim().length < 10) {
                    return AppLocalizations.of(
                      context,
                    ).t('descriptionTooShort');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ingreidentsController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).t('ingredients'),
                  hintText: AppLocalizations.of(context).t('itemIngredients'),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(
                      context,
                    ).t('pleaseEnterIngredients');
                  }
                  final parts = value
                      .split(',')
                      .map((s) => s.trim())
                      .where((s) => s.isNotEmpty)
                      .toList();
                  if (parts.isEmpty) {
                    return AppLocalizations.of(
                      context,
                    ).t('pleaseListAtLeastOneIngredient');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Category selector
              Consumer<MenuProvider>(
                builder: (context, menuProvider, _) {
                  return ValueListenableBuilder(
                    valueListenable: selectedCategoryId,
                    builder: (context, value, child) {
                      return DropdownButtonFormField<int>(
                        initialValue: value,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).t('category'),
                          border: const OutlineInputBorder(),
                        ),
                        items: menuProvider.categories
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat.categoryId,
                                child: Text(cat.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          selectedCategoryId.value = value ?? 1;
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: isAvailable,
                builder: (context, value, child) {
                  return CheckboxListTile(
                    title: Text(AppLocalizations.of(context).t('available')),
                    value: value,
                    onChanged: (value) {
                      isAvailable.value = value ?? true;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).t('cancel')),
        ),
        ElevatedButton(
          onPressed: isUploadingImage.value
              ? null
              : () {
                  if ((_formKey.currentState?.validate() ?? false)) {
                    widget.onSave(
                      nameController.text,
                      double.parse(priceController.text),
                      descriptionController.text,
                      selectedCategoryId.value,
                      isAvailable.value,
                      imageUrl.value ?? '',
                      ingreidentsController.text,
                    );
                  }
                },
          child: Text(
            widget.isEdit
                ? AppLocalizations.of(context).t('update')
                : AppLocalizations.of(context).t('add'),
          ),
        ),
      ],
    );
  }
}
