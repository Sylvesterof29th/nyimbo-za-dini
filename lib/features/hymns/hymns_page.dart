import 'hymns_details_page.dart';
import '../../data/local/local_storage_service.dart';
import 'package:flutter/material.dart';

import '../../data/models/hymn.dart';
import '../../data/repositories/hymn_repositories.dart';
import '../../shared/widgets/hymn_card.dart';
import '../../shared/widgets/diocese_app_bar.dart';

class HymnsPage extends StatefulWidget {
  const HymnsPage({super.key});

  @override
  State<HymnsPage> createState() => _HymnsPageState();
}

class _HymnsPageState extends State<HymnsPage> {
  final HymnRepository _repository = HymnRepository();

  final LocalStorageService _storage = LocalStorageService();

  List<Hymn> _hymns = [];
  List<Hymn> _filteredHymns = [];

  Set<String> _favoriteIds = {};

  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadHymns();
  }

  Future<void> _loadHymns() async {
    final hymns = await _repository.getHymns();

    final favorites = await _storage.getFavoriteHymns();

    if (!mounted) return;

    setState(() {
      _hymns = hymns;
      _filteredHymns = hymns;
      _favoriteIds = favorites.toSet();
      _isLoading = false;
    });
  }

  void _searchHymns(String query) {
    final results = _hymns.where((hymn) {
      final title = hymn.title.toLowerCase();
      final number = hymn.number.toLowerCase();
      final search = query.toLowerCase();

      return title.contains(search) || number.contains(search);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredHymns = results;
    });
  }

  Future<void> _toggleFavorite(Hymn hymn) async {
    final id = hymn.id.toString();

    if (_favoriteIds.contains(id)) {
      await _storage.removeFavorite(id);

      setState(() {
        _favoriteIds.remove(id);
      });
    } else {
      await _storage.addFavorite(id);

      setState(() {
        _favoriteIds.add(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DioceseAppBar(
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: _searchHymns,
              decoration: InputDecoration(
                hintText: 'Tafuta kwa namba au jina...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchHymns('');
                        },
                        icon: const Icon(Icons.clear_rounded),
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredHymns.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: _filteredHymns.length,
                    itemBuilder: (context, index) {
                      final hymn = _filteredHymns[index];

                      return HymnCard(
                        number: hymn.number,
                        title: hymn.title,
                        isFavorite: _favoriteIds.contains(hymn.id.toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HymnDetailsPage(
                                hymn: hymn,
                                hymns: _filteredHymns,
                                currentIndex: index,
                              ),
                            ),
                          );
                        },
                        onFavorite: () => _toggleFavorite(hymn),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Hakuna wimbo uliopatikana',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jaribu kutafuta kwa jina au namba ya wimbo.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
