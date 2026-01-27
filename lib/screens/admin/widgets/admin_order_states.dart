import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// responsive  :done

class AdminOrdersErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const AdminOrdersErrorState({
    required this.error,
    required this.onRetry,
    super.key,
  });

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
              size: SizeConfig.blockWidth * 20,
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
            SizedBox(height: SizeConfig.blockHight * 4),
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
