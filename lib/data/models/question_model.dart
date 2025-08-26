class Question {
  final String questionId;
  final int subjectId;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String reference;

  Question({
    required this.questionId,
    required this.subjectId,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.reference,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      subjectId: json['subject_id'],
      questionText: json['question_text'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
      explanation: json['explanation'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'subject_id': subjectId,
      'question_text': questionText,
      'options': options,
      'correct_answer': correctAnswer,
      'explanation': explanation,
      'reference': reference,
    };
  }
}
