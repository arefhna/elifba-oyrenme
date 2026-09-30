import 'package:flutter/material.dart';
import '../data/arabic_letters.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import 'letter_detail_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  Set<String> _learned = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final learned = await ProgressService.getLearned();
    if (mounted) setState(() => _learned = learned);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Öyrənmə'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_learned.length}/28',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: arabicLetters.length,
        itemBuilder: (context, index) {
          final letter = arabicLetters[index];
          final isLearned = _learned.contains(letter.letter);

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + index * 20),
            tween: Tween(begin: 0, end: 1),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: isLearned
                    ? AppTheme.greenGradient
                    : isDark
                        ? LinearGradient(
                            colors: [
                              AppTheme.darkCard,
                              AppTheme.darkSurface,
                            ],
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.grey.shade50,
                            ],
                          ),
                border: Border.all(
                  color: isLearned
                      ? AppTheme.accentGold
                      : AppTheme.primaryGreen.withOpacity(0.15),
                  width: isLearned ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isLearned
                        ? AppTheme.primaryGreen.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: isLearned ? 15 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LetterDetailScreen(letter: letter),
                      ),
                    );
                    _load();
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              letter.letter,
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                color: isLearned
                                    ? Colors.white
                                    : AppTheme.primaryGreen,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              letter.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isLearned
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isLearned)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.accentGold,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
