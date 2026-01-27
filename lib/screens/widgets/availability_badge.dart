import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';

// response : done

class AvailabilityBadge extends StatelessWidget {
  final bool available;

  const AvailabilityBadge({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 3,
        vertical: SizeConfig.blockHight * 0.8,
      ),
      decoration: BoxDecoration(
        color: available ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        available
            ? AppLocalizations.of(context).t('available')
            : AppLocalizations.of(context).t('outOfStock'),
        style: TextStyle(
          fontSize: SizeConfig.blockHight * 1.7,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
