import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/beautiful_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tətbiq Haqqında'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: AppTheme.greenGradient,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                    border: Border.all(
                      color: AppTheme.accentGold,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'ا',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Əlifba Öyrənmə',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Versiya 1.0.0',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BeautifulCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.info, 'Tətbiq haqqında'),
                const SizedBox(height: 12),
                const Text(
                  'Bu tətbiq ərəb əlifbasını öyrənmək üçün hazırlanmışdır. '
                  '28 ərəb hərfi, hər birinin adı, oxunuşu, mövqeləri '
                  'və nümunə sözləri ilə birlikdə təqdim olunur. '
                  'Həmçinin test rejimi ilə biliklərinizi yoxlaya bilərsiniz.',
                  style: TextStyle(fontSize: 15, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          BeautifulCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.star, 'Xüsusiyyətlər'),
                const SizedBox(height: 12),
                _feature(Icons.volume_up, 'Səsli tələffüz'),
                _feature(Icons.menu_book, '28 hərf tam məlumat'),
                _feature(Icons.quiz, '3 növ test rejimi'),
                _feature(Icons.dark_mode, 'Qaranlıq tema'),
                _feature(Icons.auto_awesome, 'Mövqe öyrənmə'),
                _feature(Icons.lightbulb_outline, 'Nümunə sözlər'),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryGreen.withOpacity(0.15),
          ),
          child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _feature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
