import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/admin/widgets/admin_home_recent_activity.dart';
import 'package:foodapp/screens/widgets/my_drawer.dart';
import 'package:foodapp/screens/widgets/welcome_box.dart';
import 'package:foodapp/screens/admin/widgets/admin_home_stats.dart';
import 'package:foodapp/screens/admin/widgets/admin_home_quick_action.dart';
import 'package:provider/provider.dart';

// responsive : done
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('adminDashboard')),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              const WelcomeBox(),
              SizedBox(height: SizeConfig.blockHight * 3),

              // Stats Cards - Use Consumer for better performance
              Consumer2<OrderProvider, MenuProvider>(
                builder: (context, orderProvider, menuProvider, child) {
                  return AdminStatsGrid(
                    orders: orderProvider.orders
                        .where((o) => o.createdAt?.day == DateTime.now().day)
                        .toList(),
                    menuItems: menuProvider.items,
                  );
                },
              ),
              SizedBox(height: SizeConfig.blockHight * 2.5),

              // Quick Actions
              Text(
                AppLocalizations.of(context).t('quickActions'),
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.blockHight * 2),
              AdminQuickActionsGrid(parentContext: context),
              SizedBox(height: SizeConfig.blockHight * 2),

              // Recent Activity - Use Consumer for better performance
              Text(
                AppLocalizations.of(context).t('recentActivity'),
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  return RecentActivityCard(orders: orderProvider.orders);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
