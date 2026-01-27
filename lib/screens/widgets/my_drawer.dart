import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/screens/widgets/logout_button.dart';
import 'package:provider/provider.dart';

// responsive : done

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user!;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    children: [
                      user.imageUrl == null || user.imageUrl!.isEmpty
                          ? CircleAvatar(
                              radius: SizeConfig.blockHight * 4.25,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Text(
                                user.name.isNotEmpty
                                    ? user.name[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockHight * 3.5,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: SizeConfig.blockHight * 4.25,
                              backgroundImage: CachedNetworkImageProvider(
                                user.imageUrl!,
                              ),
                            ),
                      SizedBox(width: SizeConfig.blockHight * 1.5),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockHight * 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockHight * 0.5),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockHight,
                                vertical: SizeConfig.blockHight * 0.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.blockHight * 1.5,
                                ),
                              ),
                              child: Text(
                                user.role.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockHight * 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: SizeConfig.blockHight * 2.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/accountScreen');
                        },
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.home, size: SizeConfig.blockHight * 2.5),
                  title: Text(AppLocalizations.of(context).t('home')),
                  onTap: () => Navigator.pop(context),
                ),

                if (user.role != 'user')
                  ListTile(
                    leading: Icon(
                      Icons.menu_book,
                      size: SizeConfig.blockHight * 2.5,
                    ),
                    title: Text(AppLocalizations.of(context).t('manageMenu')),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/adminMenuScreen');
                    },
                  ),

                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    size: SizeConfig.blockHight * 2.5,
                  ),
                  title: Text(AppLocalizations.of(context).t('orders')),
                  onTap: () {
                    Navigator.pop(context);
                    user.role == 'user'
                        ? Navigator.pushNamed(context, '/userCartScreen')
                        : Navigator.pushNamed(context, '/adminOrdersScreen');
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.person,
                    size: SizeConfig.blockHight * 2.5,
                  ),
                  title: Text(AppLocalizations.of(context).t('profile')),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/accountScreen');
                  },
                ),

                // Admin-only section
                if (user.role == 'admin')
                  Column(
                    children: [
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.group,
                          size: SizeConfig.blockHight * 2.5,
                        ),
                        title: Text(
                          AppLocalizations.of(context).t('manageUsers'),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/adminUsersScreen');
                        },
                      ),
                      // ListTile(
                      //   leading: const Icon(Icons.settings),
                      //   title: Text(AppLocalizations.of(context).t('settings')),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.pushNamed(context, '/adminSettingsScreen');
                      //   },
                      // ),

                      // statistics
                      ListTile(
                        leading: Icon(
                          Icons.bar_chart,
                          size: SizeConfig.blockHight * 2.5,
                        ),
                        title: Text(
                          AppLocalizations.of(context).t('statistics'),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            '/adminStatisticsScreen',
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.blockHight * 1.25,
              left: SizeConfig.blockHight * 2,
              right: SizeConfig.blockHight * 2,
            ),
            child: LogoutButton(),
          ),
        ],
      ),
    );
  }
}
