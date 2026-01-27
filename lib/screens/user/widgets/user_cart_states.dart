import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

class EmptyCartState extends StatelessWidget {
  const EmptyCartState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: SizeConfig.blockWidth * 25,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('yourCartIsEmpty'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              AppLocalizations.of(context).t('addSomeDeliciousItemsToYourCart'),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.restaurant_menu),
              label: Text(AppLocalizations.of(context).t('browseMenu')),
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

class EmptyOrdersState extends StatelessWidget {
  const EmptyOrdersState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: SizeConfig.blockWidth * 25,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('noOrdersYet'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              AppLocalizations.of(context).t('yourOrdersWillAppearHere'),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ErrorState({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: SizeConfig.blockWidth * 25,
              color: Colors.red[300],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('error'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              error,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context).t('retry')),
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
