import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  bool _loading = false;

  final _topics = ["Python", "Java", "DSA", "Flutter", "AI"];

  Future<void> _startQuiz(String topic) async {
    if (topic.trim().isEmpty) return;

    setState(() => _loading = true);

    try {
      final questions = await ApiService.getQuiz(topic.trim());
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        '/quiz',
        arguments: {'topic': topic.trim(), 'questions': questions},
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to load quiz: $e"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildInputCard(),
                  const SizedBox(height: 32),
                  _buildStartButton(),
                  const SizedBox(height: 32),
                  _buildTopicChips(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
              Icons.quiz_rounded,
              size: 64,
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.9),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.5, 0.5)),
        const SizedBox(height: 16),
        Text(
          "Quizzer",
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: -0.3),
        const SizedBox(height: 8),
        Text(
          "Test your knowledge",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter a topic",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(
              hintText: "e.g. Python, Flutter, AI...",
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 16,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.7),
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF7C4DFF),
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
            onSubmitted: _loading ? null : (_) => _startQuiz(_controller.text),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2);
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      height: 56,
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
          onTap: _loading ? null : () => _startQuiz(_controller.text),
          child: Center(
            child: _loading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start Quiz",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildTopicChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _topics.asMap().entries.map((entry) {
        final index = entry.key;
        final topic = entry.value;
        return GestureDetector(
              onTap: _loading ? null : () => _startQuiz(topic),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  topic,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(delay: (1000 + index * 100).ms, duration: 400.ms)
            .slideY(begin: 0.3);
      }).toList(),
    );
  }
}
