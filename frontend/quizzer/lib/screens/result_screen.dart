import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/question_model.dart';

class ResultScreen extends StatelessWidget {
  final String topic;
  final List<QuestionModel> questions;
  final List<String> userAnswers;
  final int score;

  const ResultScreen({
    super.key,
    required this.topic,
    required this.questions,
    required this.userAnswers,
    required this.score,
  });

  int get total => questions.length;
  double get percentage => score / total;
  String get performance {
    if (percentage >= 0.9) return "Outstanding!";
    if (percentage >= 0.7) return "Great Job!";
    if (percentage >= 0.5) return "Good Effort";
    return "Keep Practicing";
  }

  Color get performanceColor {
    if (percentage >= 0.9) return const Color(0xFF00C853);
    if (percentage >= 0.7) return const Color(0xFF448AFF);
    if (percentage >= 0.5) return const Color(0xFFFFB300);
    return const Color(0xFFFF1744);
  }

  IconData get performanceIcon {
    if (percentage >= 0.9) return Icons.emoji_events_rounded;
    if (percentage >= 0.7) return Icons.rocket_launch_rounded;
    if (percentage >= 0.5) return Icons.thumb_up_rounded;
    return Icons.replay_rounded;
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildScoreCircle(context),
                const SizedBox(height: 20),
                _buildPerformanceMessage(context),
                const SizedBox(height: 32),
                _buildStatsRow(context),
                const SizedBox(height: 32),
                _buildReviewSection(context),
                const SizedBox(height: 24),
                _buildActionButtons(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCircle(BuildContext context) {
    return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: percentage),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (_, value, _) {
            return SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 10,
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        performanceColor,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(performanceIcon, color: performanceColor, size: 28),
                      const SizedBox(height: 4),
                      Text(
                        "${(value * total).round()}",
                        style: GoogleFonts.poppins(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "of $total",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
        .animate()
        .scale(begin: const Offset(0.5, 0.5), duration: 600.ms)
        .fadeIn(duration: 600.ms);
  }

  Widget _buildPerformanceMessage(BuildContext context) {
    return Column(
      children: [
        Text(
          performance,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: performanceColor,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
        const SizedBox(height: 6),
        Text(
          "on $topic",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ).animate().fadeIn(delay: 500.ms),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final correct = score;
    final incorrect = total - score;

    return Row(
      children: [
        _buildStatCard(
          "Correct",
          "$correct",
          const Color(0xFF00C853),
          Icons.check_circle_rounded,
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
        const SizedBox(width: 12),
        _buildStatCard(
          "Incorrect",
          "$incorrect",
          const Color(0xFFFF1744),
          Icons.cancel_rounded,
        ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3),
        const SizedBox(width: 12),
        _buildStatCard(
          "Accuracy",
          "${(percentage * 100).round()}%",
          performanceColor,
          Icons.trending_up_rounded,
        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rate_review_rounded,
                color: Colors.white.withValues(alpha: 0.7),
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                "Answer Review",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(questions.length, (index) {
            final q = questions[index];
            final userAns = index < userAnswers.length
                ? userAnswers[index]
                : "";
            final correct = q.isCorrect(userAns);

            return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: correct
                        ? const Color(0xFF00C853).withValues(alpha: 0.08)
                        : const Color(0xFFFF1744).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: correct
                          ? const Color(0xFF00C853).withValues(alpha: 0.3)
                          : const Color(0xFFFF1744).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q${index + 1}: ${q.question}",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            correct ? Icons.check_circle : Icons.cancel,
                            size: 16,
                            color: correct
                                ? const Color(0xFF00C853)
                                : const Color(0xFFFF1744),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Your answer: $userAns",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: correct
                                  ? const Color(0xFF00C853)
                                  : const Color(0xFFFF1744),
                            ),
                          ),
                        ],
                      ),
                      if (!correct) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Color(0xFF00C853),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Correct: ${q.answer}",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color(0xFF00C853),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: (900 + index * 80).ms, duration: 300.ms)
                .slideX(begin: 0.2);
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C4DFF), Color(0xFF448AFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Play Again",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3),
      ],
    );
  }
}
