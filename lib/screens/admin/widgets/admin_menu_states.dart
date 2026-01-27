import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// responsive : done

class AdminMenuEmptyState extends StatelessWidget {
  final VoidCallback onAddItem;

  const AdminMenuEmptyState({required this.onAddItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: SizeConfig.blockWidth * 20,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              'No Menu Items',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              'Start by adding your first menu item',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            SizedBox(height: SizeConfig.blockHight * 4),
            ElevatedButton.icon(
              onPressed: onAddItem,
              icon: const Icon(Icons.add),
              label: const Text('Add First Item'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockHight * 3,
                  vertical: SizeConfig.blockHight * 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminMenuNoResultsState extends StatelessWidget {
  final VoidCallback onClearFilters;

  const AdminMenuNoResultsState({required this.onClearFilters, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: SizeConfig.blockWidth * 20,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('noItemsFound'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              AppLocalizations.of(context).t('tryadjustingyourfilters'),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            SizedBox(height: SizeConfig.blockHight * 4),
            OutlinedButton.icon(
              onPressed: onClearFilters,
              icon: const Icon(Icons.clear_all),
              label: Text(AppLocalizations.of(context).t('clearFilters')),
            ),
          ],
        ),
      ),
    );
  }
}
