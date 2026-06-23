import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String topic;
  final List<QuestionModel> questions;

  const QuizScreen({super.key, required this.topic, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _showFeedback = false;
  final List<String> _userAnswers = [];

  QuestionModel get _currentQuestion => widget.questions[_currentIndex];
  double get _progress => (_currentIndex + 1) / widget.questions.length;

  void _selectOption(String option) {
    if (_showFeedback) return;

    setState(() {
      _selectedAnswer = option;
      _showFeedback = true;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      _userAnswers.add(_selectedAnswer!);

      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _showFeedback = false;
        });
      } else {
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (widget.questions[i].isCorrect(_userAnswers[i])) {
        score++;
      }
    }

    Navigator.pushNamed(
      context,
      '/result',
      arguments: {
        'topic': widget.topic,
        'questions': widget.questions,
        'userAnswers': _userAnswers,
        'score': score,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A0033), Color(0xFF0D0D2B), Color(0xFF0A0A1A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildProgressBar(),
              const SizedBox(height: 24),
              Expanded(child: _buildQuestionContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white70),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.topic,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "${_currentIndex + 1}/${widget.questions.length}",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: _progress),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (_, value, _) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF7C4DFF),
              ),
              minHeight: 6,
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildQuestionCard(),
          const SizedBox(height: 28),
          _buildOptionsList(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Question ${_currentIndex + 1}",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7C4DFF),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _currentQuestion.question,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ],
          ),
        )
        .animate(key: ValueKey(_currentIndex))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3, duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildOptionsList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _currentQuestion.options.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final option = _currentQuestion.options[index];
          return _buildOption(option, index);
        },
      ),
    );
  }

  Widget _buildOption(String option, int index) {
    final isSelected = _selectedAnswer == option;
    final isThisCorrect = _currentQuestion.isCorrect(option);

    Color bgColor = Colors.white.withValues(alpha: 0.06);
    Color borderColor = Colors.white.withValues(alpha: 0.1);
    Color textColor = Colors.white.withValues(alpha: 0.85);
    IconData? icon;

    if (_showFeedback) {
      if (isThisCorrect) {
        bgColor = const Color(0xFF00C853).withValues(alpha: 0.15);
        borderColor = const Color(0xFF00C853);
        textColor = const Color(0xFF00C853);
        icon = Icons.check_circle_rounded;
      } else if (isSelected && !isThisCorrect) {
        bgColor = const Color(0xFFFF1744).withValues(alpha: 0.15);
        borderColor = const Color(0xFFFF1744);
        textColor = const Color(0xFFFF1744);
        icon = Icons.cancel_rounded;
      }
    }

    final labels = ["A", "B", "C", "D"];

    return GestureDetector(
      onTap: () => _selectOption(option),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _showFeedback && isThisCorrect
                            ? const Color(0xFF00C853).withValues(alpha: 0.2)
                            : _showFeedback && isSelected && !isThisCorrect
                            ? const Color(0xFFFF1744).withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: icon != null
                            ? Icon(icon, color: textColor, size: 20)
                            : Text(
                                labels[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        option,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate(key: ValueKey("${_currentIndex}_$index"))
              .fadeIn(delay: (200 + index * 80).ms, duration: 300.ms)
              .slideX(begin: 0.2),
    );
  }
}
