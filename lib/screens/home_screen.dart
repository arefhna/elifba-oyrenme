import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'learn_screen.dart';
import 'quiz_screen.dart';
import 'about_screen.dart';
import 'developer_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Əlifba Öyrənmə'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            tooltip: isDark ? 'İşıqlı tema' : 'Qaranlıq tema',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Başlıq kartı
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'ا',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ərəb Əlifbası',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '28 hərfi öyrən və test et',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Öyrənmə
          _menuCard(
            context,
            icon: Icons.menu_book,
            title: 'Öyrənmə',
            subtitle: '28 hərfi tam öyrən',
            color: AppTheme.primaryGreen,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LearnScreen()),
            ),
          ),
          const SizedBox(height: 12),

          // Test
          _menuCard(
            context,
            icon: Icons.quiz,
            title: 'Test',
            subtitle: 'Biliklərini yoxla',
            color: AppTheme.accentGold,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
          ),
          const SizedBox(height: 12),

          // Haqqında
          _menuCard(
            context,
            icon: Icons.info_outline,
            title: 'Tətbiq Haqqında',
            subtitle: 'Məlumat və versiya',
            color: Colors.blueGrey,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
          const SizedBox(height: 12),

          // Proqramçı
          _menuCard(
            context,
            icon: Icons.code,
            title: 'Proqramçı',
            subtitle: 'Arif Qocayev',
            color: Colors.indigo,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeveloperScreen()),
            ),
          ),
          const SizedBox(height: 24),

          // Footer
          Center(
            child: Column(
              children: [
                Text(
                  '© 2026 Arif Qocayev',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'codestack.az studio',
                  style: TextStyle(
                    color: AppTheme.accentGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          radius: 28,
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
