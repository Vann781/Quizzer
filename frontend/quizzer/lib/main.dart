import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const QuizzerApp());
}

class QuizzerApp extends StatelessWidget {
  const QuizzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D2B),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C4DFF),
          secondary: Color(0xFF448AFF),
          surface: Color(0xFF1A1A3E),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _buildPageRoute(const HomeScreen(), Offset.zero);
          case '/quiz':
            final args = settings.arguments as Map<String, dynamic>;
            return _buildPageRoute(
              QuizScreen(topic: args['topic'], questions: args['questions']),
              const Offset(1.0, 0.0),
            );
          case '/result':
            final args = settings.arguments as Map<String, dynamic>;
            return _buildPageRoute(
              ResultScreen(
                topic: args['topic'],
                questions: args['questions'],
                userAnswers: args['userAnswers'],
                score: args['score'],
              ),
              const Offset(0.0, 1.0),
            );
          default:
            return _buildPageRoute(const HomeScreen(), Offset.zero);
        }
      },
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page, Offset begin) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
