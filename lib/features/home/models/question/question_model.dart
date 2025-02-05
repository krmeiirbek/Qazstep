abstract class Question {
  final String examType;
  final String subject;
  final String language;
  final String type;

  Question({
    required this.examType,
    required this.subject,
    required this.language,
    required this.type,
  });

  factory Question.fromFirestore(Map<String, dynamic> data) {
    switch (data['type']) {
      case 'single_choice':
        return SingleChoiceQuestion.fromMap(data);
      case 'text_question':
        return TextQuestion.fromMap(data);
      case 'matching':
        return MatchingQuestion.fromMap(data);
      case 'multiple_choice':
        return MultipleChoiceQuestion.fromMap(data);
      default:
        throw Exception("Unknown question type");
    }
  }
}

class SingleChoiceQuestion extends Question {
  final String questionText;
  final String? questionImage;
  final List<String> options;
  final String correctAnswer;
  final String? text;
  final String? textImage;

  SingleChoiceQuestion({
    required super.examType,
    required super.subject,
    required super.language,
    required this.questionText,
    this.questionImage,
    this.text,
    this.textImage,
    required this.options,
    required this.correctAnswer,
  }) : super(
          type: 'single_choice',
        );

  factory SingleChoiceQuestion.fromMap(Map<String, dynamic> data) {
    return SingleChoiceQuestion(
      examType: data['examType'] ?? '',
      subject: data['subject'] ?? '',
      language: data['language'] ?? '',
      questionText: data['questionText'],
      questionImage: data['questionImage'],
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'],
    );
  }

  SingleChoiceQuestion copyWith({
    String? text,
    String? textImage,
  }) {
    return SingleChoiceQuestion(
      examType: examType,
      subject: subject,
      language: language,
      questionText: questionText,
      questionImage: questionImage,
      options: options,
      correctAnswer: correctAnswer,
      text: text ?? this.text,
      textImage: textImage ?? this.textImage,
    );
  }
}

class TextQuestion extends Question {
  final String text;
  final String? textImage;
  final List<SingleChoiceQuestion> questions;

  TextQuestion({
    required super.examType,
    required super.subject,
    required super.language,
    required this.text,
    this.textImage,
    required this.questions,
  }) : super(
          type: 'text_question',
        );

  factory TextQuestion.fromMap(Map<String, dynamic> data) {
    return TextQuestion(
      examType: data['examType'],
      subject: data['subject'],
      language: data['language'],
      text: data['text'],
      textImage: data['textImage'],
      questions: (data['questions'] as List).map((q) => SingleChoiceQuestion.fromMap(q)).toList(),
    );
  }
}

class MatchingQuestion extends Question {
  final String questionText;
  final String? questionImage;
  final String subFirstQuestion;
  final String subSecondQuestion;
  final List<String> options;
  final String subFirstQuestionAnswer;
  final String subSecondQuestionAnswer;

  MatchingQuestion({
    required super.examType,
    required super.subject,
    required super.language,
    required this.questionText,
    this.questionImage,
    required this.subFirstQuestion,
    required this.subSecondQuestion,
    required this.options,
    required this.subFirstQuestionAnswer,
    required this.subSecondQuestionAnswer,
  }) : super(
          type: 'matching',
        );

  factory MatchingQuestion.fromMap(Map<String, dynamic> data) {
    return MatchingQuestion(
      examType: data['examType'],
      subject: data['subject'],
      language: data['language'],
      questionText: data['questionText'],
      questionImage: data['questionImage'],
      subFirstQuestion: data['subFirstQuestion'],
      subSecondQuestion: data['subSecondQuestion'],
      options: List<String>.from(data['options']),
      subFirstQuestionAnswer: data['subFirstQuestionAnswer'],
      subSecondQuestionAnswer: data['subSecondQuestionAnswer'],
    );
  }
}

class MultipleChoiceQuestion extends Question {
  final String questionText;
  final String? questionImage;
  final List<String> options;
  final List<String> correctAnswers;

  MultipleChoiceQuestion({
    required super.examType,
    required super.subject,
    required super.language,
    required this.questionText,
    this.questionImage,
    required this.options,
    required this.correctAnswers,
  }) : super(
          type: 'multiple_choice',
        );

  factory MultipleChoiceQuestion.fromMap(Map<String, dynamic> data) {
    return MultipleChoiceQuestion(
      examType: data['examType'],
      subject: data['subject'],
      language: data['language'],
      questionText: data['questionText'],
      questionImage: data['questionImage'],
      options: List<String>.from(data['options']),
      correctAnswers: List<String>.from(data['correctAnswers']),
    );
  }
}
