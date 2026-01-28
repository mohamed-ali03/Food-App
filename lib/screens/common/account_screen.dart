import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/user%20model/user_model.dart';
import 'package:foodapp/providers/app_settings_provider.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/screens/common/auth.dart';
import 'package:foodapp/screens/common/widgets/edit_profile_dialog.dart';
import 'package:foodapp/screens/widgets/logout_button.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/screens/common/widgets/account_profile_header.dart';
import 'package:foodapp/screens/common/widgets/account_info_card.dart';

// responsive : done
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String lang = 'En';

  @override
  void initState() {
    lang = context.read<AppSettingsProvider>().lang == 'ar' ? 'En' : 'Ar';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('profile')),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              context.read<AppSettingsProvider>().setLanguage(
                lang.toLowerCase(),
              );
              lang = lang == 'En' ? 'Ar' : 'En';
            },
            child: Text(
              lang,
              style: TextStyle(
                color: Colors.blue,
                fontSize: SizeConfig.blockHight * 1.5,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            final user = provider.user;
            if (user == null) {
              return _EmptyState();
            }

            return Column(
              children: [
                // Profile Header Section
                AccountProfileHeader(
                  user: user,
                  onEditImage: () =>
                      _showEditProfileDialog(context, user, field: 'image'),
                ),
                SizedBox(height: SizeConfig.blockHight * 3),

                // Information Cards
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockHight * 2,
                  ),
                  child: Column(
                    children: [
                      AccountInfoCard(
                        icon: Icons.person,
                        label: AppLocalizations.of(context).t('fullName'),
                        value: user.name != ''
                            ? user.name
                            : AppLocalizations.of(context).t('Unknown'),
                        onEdit: () => _showEditProfileDialog(
                          context,
                          user,
                          field: 'name',
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHight * 1.5),
                      AccountInfoCard(
                        icon: Icons.phone,
                        label: AppLocalizations.of(context).t('phoneNumber'),
                        value:
                            user.phoneNumber != '' && user.phoneNumber != null
                            ? user.phoneNumber!
                            : AppLocalizations.of(context).t('notProvided'),
                        onEdit: () => _showEditProfileDialog(
                          context,
                          user,
                          field: 'phone',
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHight * 1.5),
                      AccountInfoCard(
                        icon: Icons.phone,
                        label: AppLocalizations.of(context).t('address'),
                        value: user.address != '' && user.address != null
                            ? user.address!
                            : AppLocalizations.of(context).t('notProvided'),
                        onEdit: () => _showEditProfileDialog(
                          context,
                          user,
                          field: 'address',
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockHight * 1.5),
                      AccountInfoCard(
                        icon: Icons.badge,
                        label: AppLocalizations.of(context).t('role'),
                        value: user.role.toUpperCase() == 'USER'
                            ? AppLocalizations.of(context).t('User')
                            : user.role.toUpperCase(),
                        showEdit: false,
                        valueWidget: _RoleBadge(role: user.role),
                      ),
                      SizedBox(height: SizeConfig.blockHight * 1.5),
                      AccountInfoCard(
                        icon: Icons.block,
                        label: AppLocalizations.of(context).t('status'),
                        value: user.blocked
                            ? AppLocalizations.of(context).t('blocked')
                            : AppLocalizations.of(context).t('active'),
                        showEdit: false,
                      ),
                      if (user.role == 'user')
                        Column(
                          children: [
                            SizedBox(height: SizeConfig.blockHight * 1.5),
                            AccountInfoCard(
                              icon: Icons.badge,
                              label: AppLocalizations.of(context).t('points'),
                              value: user.buyingPoints.toString(),
                              showEdit: false,
                            ),
                          ],
                        ),

                      SizedBox(height: SizeConfig.blockHight * 1.5),
                      AccountInfoCard(
                        icon: Icons.calendar_today,
                        label: AppLocalizations.of(context).t('memberSince'),
                        value: _formatDate(user.createdAt),
                        showEdit: false,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: SizeConfig.blockHight * 4),

                // Logout Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockHight * 2,
                  ),
                  child: LogoutButton(),
                ),

                SizedBox(height: SizeConfig.blockHight * 4),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _showEditProfileDialog(
    BuildContext context,
    UserModel user, {
    required String field,
  }) {
    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(user: user, field: field),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;

  // ignore: unused_element_parameter
  const _RoleBadge({required this.role});

  Color _getRoleColor() {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'staff':
        return Colors.orange;
      case 'user':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockHight * 1.5,
        vertical: SizeConfig.blockHight * 0.75,
      ),
      decoration: BoxDecoration(
        color: _getRoleColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(SizeConfig.blockHight * 2.5),
        border: Border.all(color: _getRoleColor(), width: 1),
      ),
      child: Text(
        AppLocalizations.of(context).t(role).toUpperCase(),
        style: TextStyle(
          color: _getRoleColor(),
          fontSize: SizeConfig.blockHight * 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: SizeConfig.blockWidth * 20,
              color: Colors.grey[400],
            ),
            SizedBox(height: SizeConfig.blockHight * 3),
            Text(
              AppLocalizations.of(context).t('noUserData'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHight),
            Text(
              AppLocalizations.of(context).t('unableToLoadUserInfo'),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.blockHight * 2),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              },
              child: Text(AppLocalizations.of(context).t('goToLogin')),
            ),
          ],
        ),
      ),
    );
  }
}
