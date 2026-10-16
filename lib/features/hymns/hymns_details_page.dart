import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/theme_provider.dart';
import '../../data/local/local_storage_service.dart';
import '../../data/models/hymn.dart';
import '../../shared/widgets/app_overflow_menu.dart';

class HymnDetailsPage extends StatefulWidget {
  final Hymn hymn;
  final List<Hymn> hymns;
  final int currentIndex;
  final ThemeProvider themeProvider;

  const HymnDetailsPage({
    super.key,
    required this.hymn,
    required this.hymns,
    required this.currentIndex,
    required this.themeProvider,
  });

  @override
  State<HymnDetailsPage> createState() => _HymnDetailsPageState();
}

class _HymnDetailsPageState extends State<HymnDetailsPage> {
  final LocalStorageService _storage = LocalStorageService();

  double _fontSize = 18;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final savedFontSize = await _storage.getFontSize();

    if (!mounted) return;

    setState(() {
      _fontSize = savedFontSize;
    });
  }

  Future<void> _loadFavorite() async {
    final favorite = await _storage.isFavorite(widget.hymn.id.toString());

    if (!mounted) return;

    setState(() {
      _isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    final id = widget.hymn.id.toString();

    if (_isFavorite) {
      await _storage.removeFavorite(id);
    } else {
      await _storage.addFavorite(id);
    }

    if (!mounted) return;

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _copyLyrics() {
    final lyrics = widget.hymn.verses
        .map((verse) => verse.lines.join('\n'))
        .join('\n\n');

    Clipboard.setData(ClipboardData(text: '${widget.hymn.title}\n\n$lyrics'));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Maneno ya wimbo yamenakiliwa')),
    );
  }

  Future<void> _shareLyrics() async {
    final lyrics = widget.hymn.verses
        .map((verse) => verse.lines.join('\n'))
        .join('\n\n');

    await SharePlus.instance.share(
      ShareParams(text: '${widget.hymn.title}\n\n$lyrics'),
    );
  }

  Future<void> _increaseFontSize() async {
    if (_fontSize < 30) {
      final newSize = _fontSize + 1;

      setState(() {
        _fontSize = newSize;
      });

      await _storage.saveFontSize(newSize);
    }
  }

  Future<void> _decreaseFontSize() async {
    if (_fontSize > 14) {
      final newSize = _fontSize - 1;

      setState(() {
        _fontSize = newSize;
      });

      await _storage.saveFontSize(newSize);
    }
  }

  void _goToPreviousHymn() {
    if (widget.currentIndex <= 0) return;

    final previousIndex = widget.currentIndex - 1;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HymnDetailsPage(
          hymn: widget.hymns[previousIndex],
          hymns: widget.hymns,
          currentIndex: previousIndex,
          themeProvider: widget.themeProvider,
        ),
      ),
    );
  }

  void _goToNextHymn() {
    if (widget.currentIndex >= widget.hymns.length - 1) return;

    final nextIndex = widget.currentIndex + 1;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HymnDetailsPage(
          hymn: widget.hymns[nextIndex],
          hymns: widget.hymns,
          currentIndex: nextIndex,
          themeProvider: widget.themeProvider,
        ),
      ),
    );
  }

  void _handleSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < -300) {
      // Swipe kushoto: wimbo unaofuata.
      _goToNextHymn();
    } else if (velocity > 300) {
      // Swipe kulia: wimbo uliotangulia.
      _goToPreviousHymn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hymn = widget.hymn;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/diocese_logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Wimbo ${hymn.number}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Font ndogo',
            onPressed: _decreaseFontSize,
            icon: const Icon(Icons.text_decrease_rounded),
          ),
          IconButton(
            tooltip: 'Font kubwa',
            onPressed: _increaseFontSize,
            icon: const Icon(Icons.text_increase_rounded),
          ),
          IconButton(
            tooltip: 'Favorite',
            onPressed: _toggleFavorite,
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
          AppOverflowMenu(themeProvider: widget.themeProvider),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: _handleSwipe,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Namba ya wimbo.
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'WIMBO ${hymn.number}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Jina la wimbo.
              Text(
                hymn.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 12),

              // Aina na lugha ya wimbo.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(icon: Icons.category_outlined, text: hymn.category),
                  _InfoChip(icon: Icons.language_rounded, text: hymn.language),
                ],
              ),

              if (hymn.author != null || hymn.composer != null) ...[
                const SizedBox(height: 16),

                if (hymn.author != null)
                  Text(
                    'Mwandishi: ${hymn.author}',
                    style: const TextStyle(fontSize: 14),
                  ),

                if (hymn.composer != null)
                  Text(
                    'Mtunzi wa muziki: ${hymn.composer}',
                    style: const TextStyle(fontSize: 14),
                  ),
              ],

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Maneno ya wimbo.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hymn.verses.map((verse) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: verse.lines.map((line) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: SelectableText(
                            line,
                            style: TextStyle(fontSize: _fontSize, height: 1.7),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Vitufe vya Previous na Next.
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.currentIndex > 0
                          ? _goToPreviousHymn
                          : null,
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.currentIndex < widget.hymns.length - 1
                          ? _goToNextHymn
                          : null,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Next'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Kiashiria cha nafasi ya wimbo.
              Text(
                'Wimbo ${widget.hymn.number} • '
                '${widget.currentIndex + 1} / ${widget.hymns.length}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 10),

              // Nakili na Shiriki.
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _copyLyrics,
                      icon: const Icon(Icons.copy_rounded),
                      label: const Text('Nakili'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _shareLyrics,
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Shiriki'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(text)],
      ),
    );
  }
}
