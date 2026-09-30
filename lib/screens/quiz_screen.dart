import 'dart:math';
import 'package:flutter/material.dart';
import '../data/arabic_letters.dart';
import '../services/tts_service.dart';
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
  late int _quizType; // 0=Hərf→Ad, 1=Ad→Hərf, 2=Səs→Hərf
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

      // Təsadüfi hərf seç
      final shuffled = List<ArabicLetter>.from(arabicLetters)..shuffle(_random);
      _currentLetter = shuffled[0];
      _options = shuffled.take(4).toList()..shuffle(_random);

      // Səs testi üçün avtomatik səsləndir
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

    // 1.5 saniyə sonra növbəti sual
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
                Text(
                  '${_currentQuestion + 1}/$_totalQuestions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(
                      AppTheme.primaryGreen,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sual
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getQuestionLabel(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_quizType == 2)
                          IconButton(
                            iconSize: 80,
                            icon: const Icon(
                              Icons.volume_up,
                              color: AppTheme.primaryGreen,
                            ),
                            onPressed: () =>
                                TtsService.speak(_currentLetter.letter),
                          )
                        else
                          Text(
                            _quizType == 0
                                ? _currentLetter.letter
                                : _currentLetter.name,
                            style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Variantlar
            ...List.generate(_options.length, (index) {
              final option = _options[index];
              Color? bgColor;
              if (_answered) {
                if (option.letter == _currentLetter.letter) {
                  bgColor = Colors.green.withOpacity(0.2);
                } else if (index == _selectedIndex) {
                  bgColor = Colors.red.withOpacity(0.2);
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  color: bgColor,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    title: Center(
                      child: Text(
                        _quizType == 0 ? option.name : option.letter,
                        style: TextStyle(
                          fontSize: _quizType == 0 ? 20 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () => _checkAnswer(index),
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
