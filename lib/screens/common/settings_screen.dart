import 'package:flutter/material.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/providers/app_settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguageCode = 'en';

  @override
  void initState() {
    super.initState();
    // Load current language from provider
    _selectedLanguageCode = context.read<AppSettingsProvider>().lang;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader(AppLocalizations.of(context).t('languageSettings')),
        _buildLanguageSelector(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).t('selectLanguage'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeLanguage('en'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedLanguageCode == 'en'
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedLanguageCode == 'en'
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.language,
                            size: 32,
                            color: _selectedLanguageCode == 'en'
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context).t('english'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _selectedLanguageCode == 'en'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          if (_selectedLanguageCode == 'en')
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                AppLocalizations.of(context).t('active'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeLanguage('ar'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedLanguageCode == 'ar'
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedLanguageCode == 'ar'
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.language,
                            size: 32,
                            color: _selectedLanguageCode == 'ar'
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context).t('arabic'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _selectedLanguageCode == 'ar'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          if (_selectedLanguageCode == 'ar')
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                AppLocalizations.of(context).t('active'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguageCode = languageCode;
    });
    // Update the app language using the provider
    context.read<AppSettingsProvider>().setLanguage(languageCode);

    // Show a snackbar to confirm the change
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).t('languageChangedTo')),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
