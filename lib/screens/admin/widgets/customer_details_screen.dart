import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/user model/user_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

// responsive : done

class CustomerDetailsScreen extends StatefulWidget {
  final UserModel user;

  const CustomerDetailsScreen({super.key, required this.user});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().users.firstWhere(
      (u) => u.id == widget.user.id,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('customerDetails')),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: SizeConfig.blockHight * 6,
              backgroundImage:
                  user.imageUrl != null && user.imageUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(user.imageUrl!)
                  : null,
              child: (user.imageUrl == null || user.imageUrl!.isEmpty)
                  ? Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '')
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: TextStyle(
                fontSize: SizeConfig.blockHight * 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              AppLocalizations.of(context).t(user.role).toUpperCase(),
              style: TextStyle(
                fontSize: SizeConfig.blockHight * 1.75,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: SizeConfig.blockHight * 2),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  user.phoneNumber ??
                      AppLocalizations.of(context).t('notProvided'),
                  style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                ),
                subtitle: Text(
                  AppLocalizations.of(context).t('phone'),
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  size: SizeConfig.blockHight * 2.5,
                ),
                title: Text(
                  _formatDate(user.createdAt),
                  style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                ),
                subtitle: Text(
                  AppLocalizations.of(context).t('memberSince'),
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.point_of_sale,
                  size: SizeConfig.blockHight * 2.5,
                ),
                title: Text(
                  user.buyingPoints.toString(),
                  style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                ),
                subtitle: Text(
                  AppLocalizations.of(context).t('points'),
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 1.5,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Card(
              child: ListTile(
                leading: Icon(Icons.block, size: SizeConfig.blockHight * 2.5),
                title: Text(
                  user.blocked
                      ? AppLocalizations.of(context).t('blocked')
                      : AppLocalizations.of(context).t('active'),
                  style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                ),
                subtitle: Text(
                  AppLocalizations.of(context).t('status'),
                  style: TextStyle(
                    fontSize: SizeConfig.blockHight * 1.5,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Switch(
                  value: user.blocked,
                  onChanged: (value) async {
                    await context.read<AuthProvider>().updateProfile(
                      user.authID,
                      blocked: value,
                    );
                    if (!context.mounted) return;

                    if (context.read<AuthProvider>().error == null) {
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).t(
                              "errorUpdatingProfile",
                              data: {
                                "error": context.read<AuthProvider>().error!,
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
