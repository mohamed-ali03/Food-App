import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// responsive : done

class UserErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const UserErrorState({required this.error, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockHight * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: SizeConfig.blockWidth * 30,
              color: Colors.red[300],
            ),
            SizedBox(height: SizeConfig.blockHight * 4),
            Text(
              AppLocalizations.of(context).t('errorLoadingMenu'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontSize: SizeConfig.blockHight * 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight * 2),
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
            ),
          ],
        ),
      ),
    );
  }
}

class UserEmptyState extends StatelessWidget {
  final VoidCallback onRetry;

  const UserEmptyState({required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockHight * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: SizeConfig.blockWidth * 30,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('noMenuItems'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontSize: SizeConfig.blockHight * 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight * 1),
            Text(
              AppLocalizations.of(context).t('theMenuIsCurrentlyEmpty'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: SizeConfig.blockHight * 2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context).t('refresh')),
            ),
          ],
        ),
      ),
    );
  }
}
