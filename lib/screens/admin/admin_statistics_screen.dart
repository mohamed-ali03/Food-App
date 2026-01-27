import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/models/user%20model/user_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:foodapp/providers/order_provider.dart';
import 'package:foodapp/screens/admin/widgets/customer_details_screen.dart';
import 'package:foodapp/screens/widgets/item_details_sheet.dart';
import 'package:provider/provider.dart';

// responsive : done

class AdminStatisticsScreen extends StatefulWidget {
  const AdminStatisticsScreen({super.key});

  @override
  State<AdminStatisticsScreen> createState() => _AdminStatisticsScreenState();
}

class _AdminStatisticsScreenState extends State<AdminStatisticsScreen> {
  String _selectedRange = 'all';
  DateTime? _selectedDate;

  late List<Map<String, dynamic>> _allItemsDescending;
  late List<Map<String, dynamic>> _allOrdersWithTimestamps;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _allItemsDescending = [];
    _allOrdersWithTimestamps = [];

    final List<ItemModel> items = context.read<MenuProvider>().items;
    final List<OrderItemModel> orderItems = context
        .read<OrderProvider>()
        .orderItems;
    final List<OrderModel> orders = context.read<OrderProvider>().orders;
    final List<UserModel> users = context.read<AuthProvider>().users;

    // Calculate item statistics
    Map<int, Map<String, dynamic>> itemStats = {};

    for (var orderItem in orderItems) {
      if (orders.any(
        (order) =>
            order.orderId == orderItem.orderId &&
            order.status.toLowerCase() == 'canceled',
      )) {
        continue;
      }
      if (itemStats.containsKey(orderItem.itemId)) {
        itemStats[orderItem.itemId]!['itemQuantity'] += orderItem.quantity;
      } else {
        if (items.isNotEmpty) {
          final item = items.firstWhere(
            (item) => item.itemId == orderItem.itemId,
            orElse: () {
              final fallbackItem = ItemModel();
              fallbackItem.itemId = orderItem.itemId;
              fallbackItem.name = AppLocalizations.of(context).t('unknown');
              fallbackItem.price = 0.0;
              fallbackItem.categoryId = 0;
              return fallbackItem;
            },
          );
          itemStats[orderItem.itemId] = {
            'itemId': orderItem.itemId,
            'itemName': item.name,
            'itemPrice': item.price,
            'itemQuantity': orderItem.quantity,
            'categoryId': item.categoryId,
            'createdTime': orderItem.createdAt ?? DateTime.now(),
          };
        }
      }
    }

    _allItemsDescending = itemStats.values.toList()
      ..sort((a, b) => b['itemQuantity'].compareTo(a['itemQuantity']));

    // Store all orders with timestamps for filtering
    for (var order in orders) {
      if (order.status.toLowerCase() == 'canceled') {
        continue;
      }
      final user = users.firstWhere(
        (user) => user.authID == order.userId,
        orElse: () {
          final fallbackUser = UserModel();
          fallbackUser.authID = order.userId;
          fallbackUser.name = AppLocalizations.of(context).t('unknownUser');
          fallbackUser.phoneNumber = '';
          return fallbackUser;
        },
      );

      // Store order with timestamp for filtering
      _allOrdersWithTimestamps.add({
        'userId': order.userId,
        'userName': user.name,
        'totalPrice': order.totalPrice,
        'createdAt': order.createdAt ?? DateTime.now(),
      });
    }
  }

  Future<DateTime?> _showDateSelectionDialog() async {
    // show date picker
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return selectedDate;
  }

  Future<List<Map<String, dynamic>>> getItemsByRange(String range) async {
    final now = DateTime.now();
    List<Map<String, dynamic>> filteredItems = List.from(_allItemsDescending);

    switch (range) {
      case 'today':
        filteredItems = filteredItems.where((item) {
          final createdTime = item['createdTime'] as DateTime;
          return createdTime.year == now.year &&
              createdTime.month == now.month &&
              createdTime.day == now.day;
        }).toList();
        break;
      case 'thisWeek':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        filteredItems = filteredItems.where((item) {
          final createdTime = item['createdTime'] as DateTime;
          return createdTime.isAfter(
            weekStart.subtract(const Duration(days: 1)),
          );
        }).toList();
        break;
      case 'thisMonth':
        filteredItems = filteredItems.where((item) {
          final createdTime = item['createdTime'] as DateTime;
          return createdTime.year == now.year && createdTime.month == now.month;
        }).toList();
        break;
      case 'thisYear':
        filteredItems = filteredItems.where((item) {
          final createdTime = item['createdTime'] as DateTime;
          return createdTime.year == now.year;
        }).toList();
        break;
      case 'specificDay':
        if (_selectedDate == null) return filteredItems;
        filteredItems = filteredItems.where((item) {
          final createdTime = item['createdTime'] as DateTime;
          return createdTime.year == _selectedDate!.year &&
              createdTime.month == _selectedDate!.month &&
              createdTime.day == _selectedDate!.day;
        }).toList();
        break;
      default:
        break;
    }

    return filteredItems;
  }

  Future<List<Map<String, dynamic>>> getUsersByRange(String range) async {
    final now = DateTime.now();

    // Filter orders by time range
    List<Map<String, dynamic>> filteredOrders = List.from(
      _allOrdersWithTimestamps,
    );

    switch (range) {
      case 'today':
        filteredOrders = filteredOrders.where((order) {
          final createdTime = order['createdAt'] as DateTime;
          return createdTime.year == now.year &&
              createdTime.month == now.month &&
              createdTime.day == now.day;
        }).toList();
        break;
      case 'thisWeek':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        filteredOrders = filteredOrders.where((order) {
          final createdTime = order['createdAt'] as DateTime;
          return createdTime.isAfter(
            weekStart.subtract(const Duration(days: 1)),
          );
        }).toList();
        break;
      case 'thisMonth':
        filteredOrders = filteredOrders.where((order) {
          final createdTime = order['createdAt'] as DateTime;
          return createdTime.year == now.year && createdTime.month == now.month;
        }).toList();
        break;
      case 'thisYear':
        filteredOrders = filteredOrders.where((order) {
          final createdTime = order['createdAt'] as DateTime;
          return createdTime.year == now.year;
        }).toList();
        break;
      case 'specificDay':
        if (_selectedDate == null) return filteredOrders;
        filteredOrders = filteredOrders.where((order) {
          final createdTime = order['createdAt'] as DateTime;
          return createdTime.year == _selectedDate!.year &&
              createdTime.month == _selectedDate!.month &&
              createdTime.day == _selectedDate!.day;
        }).toList();
        break;
      default:
        break;
    }

    // Calculate user stats from filtered orders
    Map<String, Map<String, dynamic>> filteredUserStats = {};

    for (var order in filteredOrders) {
      if (filteredUserStats.containsKey(order['userId'])) {
        filteredUserStats[order['userId']]!['userTotalOrders'] += 1;
        filteredUserStats[order['userId']]!['userTotalSpent'] +=
            order['totalPrice'];
      } else {
        filteredUserStats[order['userId']] = {
          'userId': order['userId'],
          'userName': order['userName'],
          'userTotalOrders': 1,
          'userTotalSpent': order['totalPrice'],
        };
      }
    }

    // Convert to list and sort by number of orders (descending)
    return filteredUserStats.values.toList()
      ..sort((a, b) => b['userTotalOrders'].compareTo(a['userTotalOrders']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('statistics')),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Range Selector
            _buildTimeRangeSelector(),
            SizedBox(height: SizeConfig.blockHight * 3),

            // Best Items Section
            _buildBestItemsSection(),
            SizedBox(height: SizeConfig.blockHight * 3),

            // Best Users Section
            _buildBestUsersSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.blockHight * 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: SizeConfig.blockHight * 1.25,
            offset: Offset(0, SizeConfig.blockHight * 0.25),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRange,
          isExpanded: true,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockHight * 2,
            vertical: SizeConfig.blockHight * 1.5,
          ),
          items: [
            DropdownMenuItem(
              value: 'all',
              child: Text(AppLocalizations.of(context).t('allTime')),
            ),
            DropdownMenuItem(
              value: 'today',
              child: Text(AppLocalizations.of(context).t('today')),
            ),
            DropdownMenuItem(
              value: 'thisWeek',
              child: Text(AppLocalizations.of(context).t('thisWeek')),
            ),
            DropdownMenuItem(
              value: 'thisMonth',
              child: Text(AppLocalizations.of(context).t('thisMonth')),
            ),
            DropdownMenuItem(
              value: 'thisYear',
              child: Text(AppLocalizations.of(context).t('thisYear')),
            ),
            DropdownMenuItem(
              value: 'specificDay',
              child: Text(
                _selectedDate == null
                    ? AppLocalizations.of(context).t('specificDay')
                    : _selectedDate!.toString().split(' ')[0],
              ),
            ),
          ],
          onChanged: (value) async {
            if (value == 'specificDay') {
              final date = await _showDateSelectionDialog();
              if (date == null) return;

              setState(() {
                _selectedRange = value!;
                _selectedDate = date;
              });
            } else {
              setState(() {
                _selectedRange = value!;
                _selectedDate = null;
              });
            }
          },
        ),
      ),
    );
  }

  void showAllItems() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizeConfig.blockHight * 2),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockHight * 2,
              vertical: SizeConfig.blockHight * 1.5,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _allItemsDescending
                    .map(
                      (item) => _itemListTile(
                        item,
                        _allItemsDescending.indexOf(item),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBestItemsSection() {
    Future<List<Map<String, dynamic>>> items = getItemsByRange(_selectedRange);

    return FutureBuilder(
      future: items,
      builder: (context, asyncSnapshot) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockHight * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.green[600],
                          size: SizeConfig.blockHight * 3,
                        ),
                        SizedBox(width: SizeConfig.blockHight),
                        Text(
                          AppLocalizations.of(context).t('bestItems'),
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 2.25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      // show model button sheet to show all items
                      onPressed: showAllItems,
                      child: Text(
                        AppLocalizations.of(context).t('viewAll'),
                        style: TextStyle(color: Colors.green[600]),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: asyncSnapshot.data?.take(5).length ?? 0,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = asyncSnapshot.data!.take(5).elementAt(index);
                  return _itemListTile(item, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showAllUsers() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizeConfig.blockHight * 2),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockHight * 2,
              vertical: SizeConfig.blockHight * 1.5,
            ),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getUsersByRange('all'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.blockHight * 3),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load users'));
                }

                final users = snapshot.data ?? [];

                if (users.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      users.length,
                      (index) => _userListTile(users[index], index),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBestUsersSection() {
    Future<List<Map<String, dynamic>>> users = getUsersByRange(_selectedRange);

    return FutureBuilder(
      future: users,
      builder: (context, asyncSnapshot) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeConfig.blockHight * 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: SizeConfig.blockHight * 1.25,
                offset: Offset(0, SizeConfig.blockHight * 0.25),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockHight * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.blue[600],
                          size: SizeConfig.blockHight * 3,
                        ),
                        SizedBox(width: SizeConfig.blockHight),
                        Text(
                          AppLocalizations.of(context).t('bestCustomers'),
                          style: TextStyle(
                            fontSize: SizeConfig.blockHight * 2.25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: showAllUsers,
                      child: Text(
                        AppLocalizations.of(context).t('viewAll'),
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: asyncSnapshot.data?.take(5).length ?? 0,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = asyncSnapshot.data?[index];
                  return _userListTile(user!, index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _itemListTile(Map<String, dynamic> item, int index) {
    return InkWell(
      onTap: () => showItemDetails(
        context,
        item: context.read<MenuProvider>().items.firstWhere(
          (i) => i.itemId == item['itemId'],
        ),
        categoryName: context
            .read<MenuProvider>()
            .categories
            .firstWhere((c) => c.categoryId == item['categoryId'])
            .name,
        needButton: false,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockHight * 2,
          vertical: SizeConfig.blockHight,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          item['itemName'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.blockHight * 1.8,
          ),
        ),
        subtitle: Text(
          '${item['itemQuantity']} ${AppLocalizations.of(context).t('orderOnly')}',
          style: TextStyle(fontSize: SizeConfig.blockHight * 2),
        ),
        trailing: Text(
          AppLocalizations.of(context).t(
            'currency',
            data: {
              "amount": (item['itemQuantity'] * item['itemPrice'])
                  .toStringAsFixed(0),
            },
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _userListTile(Map<String, dynamic> user, int index) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerDetailsScreen(
            user: context.read<AuthProvider>().users.firstWhere(
              (u) => u.authID == user['userId'],
            ),
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockHight * 2,
          vertical: SizeConfig.blockHight,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user['userName'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.blockHight * 1.8,
          ),
        ),
        subtitle: Text(
          '${user['userTotalOrders']} ${AppLocalizations.of(context).t('orderOnly')}',
          style: TextStyle(fontSize: SizeConfig.blockHight * 2),
        ),
        trailing: Text(
          AppLocalizations.of(context).t(
            'currency',
            data: {"amount": user['userTotalSpent'].toStringAsFixed(0)},
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
