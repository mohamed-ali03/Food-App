import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';

// responsive : done
class StaffStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StaffStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: SizeConfig.blockHight),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.blockHight),
              Text(label, style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }
}
