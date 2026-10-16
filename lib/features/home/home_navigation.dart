import 'package:flutter/material.dart';

import '../../core/theme/theme_provider.dart';
import '../hymns/hymns_page.dart';
import '../favorites/favorites_page.dart';

class MainNavigation extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainNavigation({super.key, required this.themeProvider});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HymnsPage(themeProvider: widget.themeProvider),
      FavoritesPage(themeProvider: widget.themeProvider),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.music_note_outlined),
            selectedIcon: Icon(Icons.music_note),
            label: 'Nyimbo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
