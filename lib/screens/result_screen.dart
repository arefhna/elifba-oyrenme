import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
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
                return Icon(
                  i < stars ? Icons.star : Icons.star_border,
                  color: AppTheme.accentGold,
                  size: 60,
                );
              }),
            ),
            const SizedBox(height: 24),

            // Başlıq
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

            // Statistika
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _statRow(
                      '✅ Düzgün',
                      '$correct',
                      Colors.green,
                    ),
                    const Divider(),
                    _statRow(
                      '❌ Səhv',
                      '$wrong',
                      Colors.red,
                    ),
                    const Divider(),
                    _statRow(
                      '📊 Uğur',
                      '$percentage%',
                      AppTheme.primaryGreen,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Düymələr
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuizScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Yenidən cəhd et'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('Ana səhifə'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
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
