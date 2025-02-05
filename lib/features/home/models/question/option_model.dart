abstract class Option {
  final String type;
  final List<String> options;

  Option({required this.type, required this.options});
}

class SingleChoiceOption extends Option {
  final String selectedAnswer;

  SingleChoiceOption({
    required super.options,
    required this.selectedAnswer,
  }) : super(type: 'single_choice');
}

class TextOption extends Option {
  final List<SingleChoiceOption> selectedAnswers;

  TextOption({
    required super.options,
    required this.selectedAnswers,
  }) : super(type: 'text_question');
}

class MatchingOption extends Option {
  final String selectedFirstAnswer;
  final String selectedSecondAnswer;

  MatchingOption({
    required super.options,
    required this.selectedFirstAnswer,
    required this.selectedSecondAnswer,
  }) : super(type: 'matching');
}

class MultipleChoiceOption extends Option {
  final List<String> selectedAnswers;

  MultipleChoiceOption({
    required super.options,
    required this.selectedAnswers,
  }) : super(type: 'multiple_choice');
}
