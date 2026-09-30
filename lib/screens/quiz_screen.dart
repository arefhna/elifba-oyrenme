import 'dart:math';
import 'package:flutter/material.dart';
import '../data/arabic_letters.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final int _totalQuestions = 10;
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  late ArabicLetter _currentLetter;
  late List<ArabicLetter> _options;
  late int _quizType;
  bool _answered = false;
  int? _selectedIndex;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentQuestion >= _totalQuestions) {
      ProgressService.saveBestScore(_correctAnswers);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            correct: _correctAnswers,
            wrong: _wrongAnswers,
            total: _totalQuestions,
          ),
        ),
      );
      return;
    }

    setState(() {
      _answered = false;
      _selectedIndex = null;
      _quizType = _random.nextInt(3);

      final shuffled = List<ArabicLetter>.from(arabicLetters)
        ..shuffle(_random);
      _currentLetter = shuffled[0];
      _options = shuffled.take(4).toList()..shuffle(_random);

      if (_quizType == 2) {
        Future.delayed(const Duration(milliseconds: 300), () {
          TtsService.speak(_currentLetter.letter);
        });
      }
    });
  }

  void _checkAnswer(int index) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _selectedIndex = index;
      if (_options[index].letter == _currentLetter.letter) {
        _correctAnswers++;
      } else {
        _wrongAnswers++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _currentQuestion++;
        _nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentQuestion + 1) / _totalQuestions;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentQuestion + 1}/$_totalQuestions',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation(
                        AppTheme.accentGold,
                      ),
                      minHeight: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sual
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: isDark
                      ? LinearGradient(colors: [
                          AppTheme.darkCard,
                          AppTheme.darkSurface,
                        ])
                      : const LinearGradient(
                          colors: [Colors.white, Color(0xFFF8F6F0)],
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getQuestionLabel(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (_quizType == 2)
                        GestureDetector(
                          onTap: () => TtsService.speak(_currentLetter.letter),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.goldGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.accentGold
                                      .withOpacity(0.5),
                                  blurRadius: 25,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.volume_up,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            _quizType == 0
                                ? _currentLetter.letter
                                : _currentLetter.name,
                            key: ValueKey(_currentQuestion),
                            style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Variantlar
            ...List.generate(_options.length, (index) {
              final option = _options[index];
              Color? bgColor;
              Color? borderColor;

              if (_answered) {
                if (option.letter == _currentLetter.letter) {
                  bgColor = Colors.green.withOpacity(0.15);
                  borderColor = Colors.green;
                } else if (index == _selectedIndex) {
                  bgColor = Colors.red.withOpacity(0.15);
                  borderColor = Colors.red;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: bgColor ??
                        (isDark ? AppTheme.darkCard : Colors.white),
                    border: Border.all(
                      color: borderColor ??
                          AppTheme.primaryGreen.withOpacity(0.15),
                      width: borderColor != null ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _checkAnswer(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Center(
                          child: Text(
                            _quizType == 0 ? option.name : option.letter,
                            style: TextStyle(
                              fontSize: _quizType == 0 ? 20 : 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getQuestionLabel() {
    switch (_quizType) {
      case 0:
        return 'Bu hərfin adı nədir?';
      case 1:
        return 'Bu ad hansı hərfdir?';
      case 2:
        return 'Səsi dinlə və hərfi seç';
      default:
        return '';
    }
  }
}
