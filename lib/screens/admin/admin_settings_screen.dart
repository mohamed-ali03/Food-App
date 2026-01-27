import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/screens/common/settings_screen.dart';

// responsive : done

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  TimeOfDay _workStart = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _workEnd = const TimeOfDay(hour: 17, minute: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('settings')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        children: [
          SettingsScreen(),

          SizedBox(height: SizeConfig.blockHight * 3),
          _buildSectionHeader(AppLocalizations.of(context).t('workingHours')),
          _buildWorkHours(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockHight * 1.5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.blockHight * 2.25,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildWorkHours() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime('start'),
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.blockHight * 1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(SizeConfig.blockHight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).t('startTime'),
                        style: TextStyle(fontSize: SizeConfig.blockHight * 1.5),
                      ),
                      Text(
                        _workStart.format(context),
                        style: TextStyle(
                          fontSize: SizeConfig.blockHight * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.blockHight * 2),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime('end'),
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.blockHight * 1.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(SizeConfig.blockHight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).t('endTime'),
                        style: TextStyle(fontSize: SizeConfig.blockHight * 1.5),
                      ),
                      Text(
                        _workEnd.format(context),
                        style: TextStyle(
                          fontSize: SizeConfig.blockHight * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(String type) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: type == 'start' ? _workStart : _workEnd,
    );

    if (picked != null) {
      setState(() {
        if (type == 'start') {
          _workStart = picked;
        } else {
          _workEnd = picked;
        }
      });
    }
  }
}
