import 'package:flutter/material.dart';

import '../../shared/widgets/hymn_card.dart';
import '../../shared/widgets/section_title.dart';

import '../../shared/widgets/diocese_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text('Karibu 👋', style: TextStyle(fontSize: 15)),

            const SizedBox(height: 4),

            const Text(
              'Imba, soma na uabudu.',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Tafuta wimbo...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Featured Hymn
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WIMBO WA LEO',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Mungu Wetu\nMungu Wetu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Hymn 001 • Anglican Hymn',
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_book_rounded),
                    label: const Text('Soma wimbo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Categories
            SectionTitle(title: 'Makundi', onSeeAll: () {}),

            const SizedBox(height: 12),

            SizedBox(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryCard(
                    icon: Icons.music_note_rounded,
                    title: 'Nyimbo',
                  ),
                  _CategoryCard(icon: Icons.church_rounded, title: 'Ibada'),
                  _CategoryCard(
                    icon: Icons.auto_awesome_rounded,
                    title: 'Sifa',
                  ),
                  _CategoryCard(
                    icon: Icons.favorite_rounded,
                    title: 'Favorites',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Popular
            SectionTitle(title: 'Nyimbo Maarufu', onSeeAll: () {}),

            const SizedBox(height: 12),

            HymnCard(
              number: '001',
              title: 'Mungu Wetu',
              onTap: () {},
              onFavorite: () {},
            ),

            HymnCard(
              number: '002',
              title: 'Wimbo wa Ibada',
              onTap: () {},
              onFavorite: () {},
            ),

            HymnCard(
              number: '003',
              title: 'Wimbo wa Sifa',
              onTap: () {},
              onFavorite: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CategoryCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),

          const SizedBox(height: 8),

          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
