import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/theme_provider.dart';
import '../../features/settings/settings_page.dart';

class AppOverflowMenu extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AppOverflowMenu({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Chaguo zaidi',
      icon: const Icon(Icons.more_vert_rounded),
      onSelected: (value) async {
        switch (value) {
          case 'settings':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsPage(themeProvider: themeProvider),
              ),
            );
            break;

          case 'about':
            SettingsPage.showAboutApp(context);
            break;

          case 'contact':
            final uri = Uri.parse('https://wa.me/255677390051');

            final opened = await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );

            if (!opened && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Imeshindikana kufungua WhatsApp.'),
                ),
              );
            }
            break;
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined),
              SizedBox(width: 12),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'about',
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded),
              SizedBox(width: 12),
              Text('About App'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'contact',
          child: Row(
            children: [
              Icon(Icons.contact_support_outlined),
              SizedBox(width: 12),
              Text('Contact Us'),
            ],
          ),
        ),
      ],
    );
  }
}
