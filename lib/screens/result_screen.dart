import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/beautiful_card.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correct;
  final int wrong;
  final int total;

  const ResultScreen({
    super.key,
    required this.correct,
    required this.wrong,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correct / total * 100).round();
    final stars = _getStars(percentage);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nəticə'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ulduzlar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 400 + i * 200),
                  tween: Tween(begin: 0, end: 1),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Icon(
                    i < stars ? Icons.star : Icons.star_border,
                    color: AppTheme.accentGold,
                    size: 70,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            Text(
              percentage >= 80
                  ? '🎉 Əla!'
                  : percentage >= 50
                      ? '👍 Yaxşı!'
                      : '📚 Daha çox öyrən',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$total sualdan $correct düzgün',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            BeautifulCard(
              child: Column(
                children: [
                  _statRow(
                    Icons.check_circle,
                    'Düzgün',
                    '$correct',
                    Colors.green,
                  ),
                  Divider(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.2),
                  ),
                  _statRow(
                    Icons.cancel,
                    'Səhv',
                    '$wrong',
                    Colors.red,
                  ),
                  Divider(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.2),
                  ),
                  _statRow(
                    Icons.percent,
                    'Uğur',
                    '$percentage%',
                    AppTheme.primaryGreen,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            GradientButton(
              label: 'Yenidən cəhd et',
              icon: Icons.refresh,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.home),
              label: const Text('Ana səhifə'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  int _getStars(int percentage) {
    if (percentage >= 90) return 3;
    if (percentage >= 70) return 2;
    if (percentage >= 50) return 1;
    return 0;
  }
}
