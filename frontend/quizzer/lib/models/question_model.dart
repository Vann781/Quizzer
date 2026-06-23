class QuestionModel {
  final String question;
  final String answer;
  final List<String> options;

  QuestionModel({
    required this.question,
    required this.answer,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json["question"],
      answer: json["answer"],
      options: List<String>.from(json["options"]),
    );
  }

  bool isCorrect(String userAnswer) {
    return userAnswer.trim().toLowerCase() == answer.trim().toLowerCase();
  }
}
