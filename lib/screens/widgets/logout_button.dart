import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:provider/provider.dart';

// responsive : done

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    final authProvider = context.read<AuthProvider>();
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: authProvider.isLoading
            ? null
            : () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context).t('logout')),
                    content: Text(
                      AppLocalizations.of(context).t('logoutConfirm'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(AppLocalizations.of(context).t('cancel')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text(AppLocalizations.of(context).t('logout')),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  await authProvider.logout();
                  if (authProvider.error == null) {
                    await orderProvider.clearAllData();
                    if (!context.mounted) return;
                    // Clear navigation stack to let main app's consumer handle routing
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authProvider.error!)),
                      );
                    }
                  }
                }
              },
        icon: Icon(Icons.logout, size: SizeConfig.blockHight * 2.5),
        label: Text(
          AppLocalizations.of(context).t('logout'),
          style: TextStyle(fontSize: SizeConfig.blockHight * 2),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHight * 2),
          side: BorderSide(
            color: Colors.red,
            width: SizeConfig.blockHight * 0.25,
          ),
          foregroundColor: Colors.red,
        ),
      ),
    );
  }
}
