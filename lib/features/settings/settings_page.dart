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
                          Expanded(
                            child: Text(
                              'Mwonekano wa programu',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      RadioGroup<ThemeMode>(
                        groupValue: themeProvider.themeMode,
                        onChanged: (mode) {
                          if (mode != null) {
                            themeProvider.setThemeMode(mode);
                          }
                        },
                        child: Column(
                          children: [
                            RadioListTile<ThemeMode>(
                              value: ThemeMode.light,
                              title: const Text('Light Mode'),
                              secondary: const Icon(Icons.light_mode_outlined),
                            ),
                            RadioListTile<ThemeMode>(
                              value: ThemeMode.dark,
                              title: const Text('Dark Mode'),
                              secondary: const Icon(Icons.dark_mode_outlined),
                            ),
                            RadioListTile<ThemeMode>(
                              value: ThemeMode.system,
                              title: const Text('System Default'),
                              secondary: const Icon(
                                Icons.settings_suggest_outlined,
                              ),
                            ),
                          ],
                        ),
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
                  subtitle: const Text('Nyimbo za Dini • SYLOT STUDIO'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => showAboutApp(context),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Nyimbo za Dini • Toleo 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showAboutApp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colors = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          title: const Text('Kuhusu programu'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/sylot_studio_logo.jpeg',
                  height: 100,
                  width: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.business_rounded,
                      size: 56,
                      color: colors.primary,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Nyimbo za Dini',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mkusanyiko wa Nyimbo za Dini '
                  'Kanisa Anglikana Tanzania.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'DEVELOPED BY',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'SYLOT STUDIO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Founder & Developer'),
                const SizedBox(height: 4),
                const Text(
                  'Sylvester K.S',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                const Text('Email: sylshagama29@gmail.com'),
                const SizedBox(height: 8),
                const Text('Version 1.0.0'),
                const SizedBox(height: 8),
                const Text('© 2026 SYLOT STUDIO'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Funga'),
            ),
          ],
        );
      },
    );
  }
}
