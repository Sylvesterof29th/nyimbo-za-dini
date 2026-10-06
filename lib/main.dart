import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/home/home_navigation.dart';

void main() {
  runApp(const NyimboZaDiniApp());
}

class NyimboZaDiniApp extends StatefulWidget {
  const NyimboZaDiniApp({super.key});

  @override
  State<NyimboZaDiniApp> createState() => _NyimboZaDiniAppState();
}

class _NyimboZaDiniAppState extends State<NyimboZaDiniApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.loadTheme();
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nyimbo za Dini',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeProvider.themeMode,
          home: MainNavigation(themeProvider: _themeProvider),
        );
      },
    );
  }
}
