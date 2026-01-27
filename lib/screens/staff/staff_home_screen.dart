import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/screens/staff/widgets/staff_stat_card.dart';

// responsive : done

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('staffDashboard')),
        elevation: 0,
      ),
      body: SafeArea(
        child: Consumer2<OrderProvider, MenuProvider>(
          builder: (context, orderProv, menuProv, child) {
            final orders = orderProv.orders;
            final pending = orders
                .where((o) => o.status.toLowerCase() == 'pending')
                .length;
            final processing = orders
                .where(
                  (o) =>
                      o.status.toLowerCase() != 'pending' &&
                      o.status.toLowerCase() != 'delivered',
                )
                .length;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(SizeConfig.blockHight * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).t('welcomeBack'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: SizeConfig.blockHight * 2),

                  // Stats row
                  Row(
                    children: [
                      Expanded(
                        child: StaffStatCard(
                          label: AppLocalizations.of(context).t('pending'),
                          value: pending.toString(),
                          color: Colors.orange,
                          icon: Icons.pending,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockHight * 2),
                      Expanded(
                        child: StaffStatCard(
                          label: AppLocalizations.of(context).t('processing'),
                          value: processing.toString(),
                          color: Colors.blue,
                          icon: Icons.restaurant,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: SizeConfig.blockHight * 2),

                  // Quick actions
                  Text(
                    AppLocalizations.of(context).t('quickActions'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/staffOrdersScreen',
                          ),
                          icon: const Icon(Icons.list_alt),
                          label: Text(
                            AppLocalizations.of(context).t('viewOrders'),
                            style: TextStyle(
                              fontSize: SizeConfig.blockHight * 1.8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/accountScreen'),
                          icon: const Icon(Icons.person),
                          label: Text(
                            AppLocalizations.of(context).t('profile'),
                            style: TextStyle(
                              fontSize: SizeConfig.blockHight * 1.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: SizeConfig.blockHight * 3),

                  // Menu summary
                  Text(
                    AppLocalizations.of(context).t('menuItems'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: SizeConfig.blockHight),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${menuProv.items.length}',
                              style: TextStyle(
                                fontSize: SizeConfig.blockHight * 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockHight * 0.5),
                            Text(
                              AppLocalizations.of(context).t('totalItems'),
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/adminMenuScreen'),
                          child: Text(
                            AppLocalizations.of(context).t('manageMenu'),
                            style: TextStyle(
                              fontSize: SizeConfig.blockHight * 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
