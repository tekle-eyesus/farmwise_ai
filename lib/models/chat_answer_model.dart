class SavedChatAnswer {
  final String question;
  final String modelAnswer;
  final DateTime savedAt;

  SavedChatAnswer({
    required this.question,
    required this.modelAnswer,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() => {
        'question': question,
        'modelAnswer': modelAnswer,
        'savedAt': savedAt.toIso8601String(),
      };

  static SavedChatAnswer fromMap(Map<dynamic, dynamic> map) => SavedChatAnswer(
        question: map['question'],
        modelAnswer: map['modelAnswer'],
        savedAt: DateTime.parse(map['savedAt']),
      );
}
