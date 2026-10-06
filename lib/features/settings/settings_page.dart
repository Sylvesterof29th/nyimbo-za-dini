import 'package:flutter/material.dart';

import '../../core/theme/theme_provider.dart';
import '../../shared/widgets/diocese_app_bar.dart';

class SettingsPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  const SettingsPage({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, child) {
        return Scaffold(
          appBar: const DioceseAppBar(),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Mipangilio',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                'Dhibiti mipangilio ya programu yako.',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.palette_outlined),
                          SizedBox(width: 12),
                          Text(
                            'Mwonekano wa programu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      RadioListTile<ThemeMode>(
                        value: ThemeMode.light,
                        groupValue: themeProvider.themeMode,
                        title: const Text('Light Mode'),
                        secondary: const Icon(Icons.light_mode_outlined),
                        onChanged: (mode) {
                          if (mode != null) {
                            themeProvider.setThemeMode(mode);
                          }
                        },
                      ),

                      RadioListTile<ThemeMode>(
                        value: ThemeMode.dark,
                        groupValue: themeProvider.themeMode,
                        title: const Text('Dark Mode'),
                        secondary: const Icon(Icons.dark_mode_outlined),
                        onChanged: (mode) {
                          if (mode != null) {
                            themeProvider.setThemeMode(mode);
                          }
                        },
                      ),

                      RadioListTile<ThemeMode>(
                        value: ThemeMode.system,
                        groupValue: themeProvider.themeMode,
                        title: const Text('System Default'),
                        secondary: const Icon(Icons.settings_suggest_outlined),
                        onChanged: (mode) {
                          if (mode != null) {
                            themeProvider.setThemeMode(mode);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('Kuhusu programu'),
                  subtitle: const Text('Nyimbo za Dini'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Nyimbo za Dini',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© Nyimbo za Dini',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
