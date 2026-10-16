import 'package:flutter/material.dart';

import '../../core/theme/theme_provider.dart';
import '../../data/local/local_storage_service.dart';
import '../../data/models/hymn.dart';
import '../../data/repositories/hymn_repositories.dart';
import '../../shared/widgets/app_overflow_menu.dart';
import '../../shared/widgets/diocese_app_bar.dart';
import '../../shared/widgets/hymn_card.dart';
import '../hymns/hymns_details_page.dart';

class FavoritesPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const FavoritesPage({super.key, required this.themeProvider});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final HymnRepository _repository = HymnRepository();
  final LocalStorageService _storage = LocalStorageService();

  List<Hymn> _allHymns = [];
  List<Hymn> _favoriteHymns = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final hymns = await _repository.getHymns();
    final favoriteIds = await _storage.getFavoriteHymns();

    if (!mounted) return;

    setState(() {
      _allHymns = hymns;

      _favoriteHymns = hymns
          .where((hymn) => favoriteIds.contains(hymn.id.toString()))
          .toList();

      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(Hymn hymn) async {
    final id = hymn.id.toString();

    await _storage.removeFavorite(id);

    if (!mounted) return;

    setState(() {
      _favoriteHymns.removeWhere((favorite) => favorite.id == hymn.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wimbo umeondolewa kwenye Favorites.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _openHymn(Hymn hymn) async {
    final currentIndex = _favoriteHymns.indexWhere(
      (item) => item.id == hymn.id,
    );

    if (currentIndex == -1) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HymnDetailsPage(
          hymn: hymn,
          hymns: _favoriteHymns,
          currentIndex: currentIndex,
          themeProvider: widget.themeProvider,
        ),
      ),
    );

    if (!mounted) return;

    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DioceseAppBar(
        actions: [AppOverflowMenu(themeProvider: widget.themeProvider)],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteHymns.isEmpty
          ? const _EmptyFavorites()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: _favoriteHymns.length,
              itemBuilder: (context, index) {
                final hymn = _favoriteHymns[index];

                return HymnCard(
                  number: hymn.number,
                  title: hymn.title,
                  isFavorite: true,
                  onTap: () => _openHymn(hymn),
                  onFavorite: () => _removeFavorite(hymn),
                );
              },
            ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            const Text(
              'Hakuna nyimbo zilizohifadhiwa',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nyimbo utakazoweka kwenye Favorites '
              'zitaonekana hapa.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
