import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
// responsive : done

class AccountInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;
  final VoidCallback? onEdit;
  final bool showEdit;

  const AccountInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueWidget,
    this.onEdit,
    this.showEdit = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockHight * 1.5),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(SizeConfig.blockHight),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(SizeConfig.blockHight),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: SizeConfig.blockHight * 3,
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.blockHight * 1.5,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle:
            valueWidget ??
            Text(
              value,
              style: TextStyle(
                fontSize: SizeConfig.blockHight * 2,
                fontWeight: FontWeight.w500,
              ),
            ),
        trailing: showEdit
            ? IconButton(
                icon: Icon(Icons.edit, size: SizeConfig.blockHight * 2.5),
                onPressed: onEdit,
                color: Colors.blue,
              )
            : null,
      ),
    );
  }
}
