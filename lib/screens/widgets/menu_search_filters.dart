import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/category model/category_model.dart';

// Responsive : done

class MenuSearchFilters extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final int? selectedCategoryId;
  final bool showAvailableOnly;
  final List<CategoryModel> categories;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int?> onCategoryChanged;
  final ValueChanged<bool> onAvailableToggle;
  final VoidCallback onClearFilters;
  final VoidCallback? addCategory;
  final ValueChanged<int>? editCategory;

  const MenuSearchFilters({
    required this.searchController,
    required this.searchQuery,
    required this.selectedCategoryId,
    required this.showAvailableOnly,
    required this.categories,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onAvailableToggle,
    required this.onClearFilters,
    this.addCategory,
    this.editCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hasFilters =
        searchQuery.isNotEmpty ||
        selectedCategoryId != null ||
        showAvailableOnly;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).t('searchItems'),
            hintStyle: TextStyle(fontSize: SizeConfig.blockHight * 2),
            prefixIcon: Icon(Icons.search, size: SizeConfig.blockHight * 4),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      onSearchChanged('');
                    },
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onSearchChanged,
        ),
        SizedBox(height: SizeConfig.blockHight * 1.5),

        // Filters Row
        Row(
          children: [
            // Category Filter
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int?>(
                    value: selectedCategoryId,
                    hint: Text(AppLocalizations.of(context).t('allCategories')),
                    style: TextStyle(
                      fontSize: SizeConfig.blockHight * 2.5,
                      color: Colors.grey[700],
                    ),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<int?>(
                        value: null,
                        child: Text(
                          AppLocalizations.of(context).t('allCategories'),
                        ),
                      ),
                      ...categories.map(
                        (cat) => DropdownMenuItem<int?>(
                          value: cat.categoryId,
                          child: SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onLongPress: () {
                                if (editCategory != null) {
                                  editCategory!(cat.categoryId);
                                }
                              },
                              child: Text(cat.name),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: onCategoryChanged,
                  ),
                ),
              ),
            ),

            // Available Filter
            Expanded(
              flex: 2,
              child: FilterChip(
                label: Text(AppLocalizations.of(context).t('availableOnly')),
                labelStyle: TextStyle(
                  fontSize: SizeConfig.blockHight * 1.5,
                  color: Colors.grey[700],
                ),
                selected: showAvailableOnly,
                onSelected: onAvailableToggle,
              ),
            ),

            if (addCategory != null)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: addCategory,
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
          ],
        ),

        // Clear Filters Button
        if (hasFilters)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton.icon(
              onPressed: onClearFilters,
              icon: Icon(Icons.clear_all, size: SizeConfig.blockHight * 2),
              label: Text(
                AppLocalizations.of(context).t('clearFilters'),
                style: TextStyle(fontSize: SizeConfig.blockHight * 1.5),
              ),
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
          ),
      ],
    );
  }
}
