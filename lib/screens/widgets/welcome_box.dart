import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

// responsive : Done

/// A unified welcome box that adapts to user role (user, admin, staff).
class WelcomeBox extends StatelessWidget {
  final String? titleOverride;
  final String? subtitleOverride;
  const WelcomeBox({super.key, this.titleOverride, this.subtitleOverride});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final role = auth.user?.role ?? 'user';

    final title = AppLocalizations.of(context).t('welcome');
    final subtitle =
        subtitleOverride ??
        (role == 'admin'
            ? AppLocalizations.of(context).t('subtitleAdmin')
            : AppLocalizations.of(context).t('subtitleUser'));

    return Container(
      padding: EdgeInsets.all(SizeConfig.blockHight * 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockHight * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.blockHight),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: SizeConfig.blockHight * 2,
            ),
          ),
        ],
      ),
    );
  }
}
