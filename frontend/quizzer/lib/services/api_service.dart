import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';

class ApiService {
  /// Change this based on your platform:
  ///   Android emulator → "http://10.0.2.2:8000"
  ///   iOS simulator    → "http://localhost:8000"
  ///   Web              → "http://localhost:8000"
  ///   Physical device  → "http://<YOUR_LAN_IP>:8000"
  static String baseUrl = "http://172.31.80.1:8000";

  static Future<List<QuestionModel>> getQuiz(String topic) async {
    final response = await http.get(Uri.parse("$baseUrl/quiz/$topic"));

    if (response.statusCode != 200) {
      throw Exception("Failed to load quiz: ${response.statusCode}");
    }

    final data = jsonDecode(response.body);
    return (data["questions"] as List)
        .map((q) => QuestionModel.fromJson(q))
        .toList();
  }
}
