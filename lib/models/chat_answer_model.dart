class SavedChatAnswer {
  final String question;
  final String modelAnswer;
  final String imagePath;
  final DateTime savedAt;

  SavedChatAnswer({
    this.question = "Crop Image Analysis",
    required this.modelAnswer,
    required this.savedAt,
    this.imagePath = '',
  });

  Map<String, dynamic> toMap() => {
        'question': question,
        'modelAnswer': modelAnswer,
        'imagePath': imagePath,
        'savedAt': savedAt.toIso8601String(),
      };

  static SavedChatAnswer fromMap(Map<dynamic, dynamic> map) => SavedChatAnswer(
        question: map['question'] ?? "Crop Image Analysis",
        modelAnswer: map['modelAnswer'],
        imagePath: map['imagePath'] ?? '',
        savedAt: DateTime.parse(map['savedAt']),
      );
}
