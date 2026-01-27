import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/user model/user_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:foodapp/screens/admin/widgets/customer_details_screen.dart';
import 'package:provider/provider.dart';

// responsive : done

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  Future<void> _changeRole(BuildContext context, UserModel user) async {
    final auth = context.read<AuthProvider>();
    final currentRole = user.role;
    final roles = ['user', 'staff', 'admin'];

    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(
          '${AppLocalizations.of(context).t('changeRoleTo')} ${user.name}',
        ),
        children: roles
            .map(
              (r) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, r),
                child: Row(
                  children: [
                    Icon(
                      r == currentRole ? Icons.check_circle : Icons.circle,
                      color: r == currentRole ? Colors.blue : Colors.grey,
                      size: SizeConfig.blockHight * 2.25,
                    ),
                    SizedBox(width: SizeConfig.blockHight),
                    Text(AppLocalizations.of(context).t(r).toUpperCase()),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );

    if (selected == null || selected == currentRole) return;

    try {
      await auth.changeUserRole(user.authID, selected);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).t(
              'roleUpdatedTo',
              data: {'role': AppLocalizations.of(context).t(selected)},
            ),
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            ).t('failedToUpdateRole', data: {'error': e.toString()}),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('manageUsers')),
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.isLoading && auth.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = auth.users;

          if (users.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.blockHight * 2.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.group_off,
                      size: SizeConfig.blockHight * 7,
                      color: Colors.grey,
                    ),
                    SizedBox(height: SizeConfig.blockHight * 1.5),
                    Text(
                      AppLocalizations.of(context).t('noUsersFound'),
                      style: TextStyle(fontSize: SizeConfig.blockHight * 2),
                    ),
                    SizedBox(height: SizeConfig.blockHight),
                    ElevatedButton(
                      onPressed: () => auth.fetchAllUsers(),
                      child: Text(AppLocalizations.of(context).t('retry')),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(SizeConfig.blockHight * 1.5),
            itemCount: users.length,
            separatorBuilder: (_, _) => SizedBox(height: SizeConfig.blockHight),
            itemBuilder: (context, index) {
              final user = users[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerDetailsScreen(user: user),
                  ),
                ),
                child: _UserTile(
                  user: user,
                  onChangeRole: () => _changeRole(context, user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onChangeRole;

  const _UserTile({required this.user, required this.onChangeRole});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(SizeConfig.blockHight * 1.5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockHight * 2,
          vertical: SizeConfig.blockHight,
        ),
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage:
                  user.imageUrl != null && user.imageUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(user.imageUrl!)
                  : null,
              child: user.imageUrl == null || user.imageUrl!.isEmpty
                  ? Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    )
                  : null,
            ),
            if (user.blocked)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: SizeConfig.blockHight * 2.5,
                  height: SizeConfig.blockHight * 2.5,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.block,
                    color: Colors.white,
                    size: SizeConfig.blockHight * 1.5,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: SizeConfig.blockHight * 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          AppLocalizations.of(context).t(
            'rolePermission',
            data: {
              'role': AppLocalizations.of(context).t(user.role).toUpperCase(),
            },
          ),
          style: TextStyle(
            fontSize: SizeConfig.blockHight * 1.75,
            color: Colors.grey[600],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, size: SizeConfig.blockHight * 2.5),
          onPressed: onChangeRole,
        ),
      ),
    );
  }
}
