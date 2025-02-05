import 'package:get/get.dart';

import '../models/question/option_model.dart';
import '../models/question/question_model.dart';

class ResultController extends GetxController {
  static ResultController get instance => Get.find();

  final loading = false.obs;
  late List<Question> questions;
  late List<Option> selectedOptions;
  final maxPoint = 0.obs;
  final resultPoint = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    questions = await Get.arguments["questions"] as List<Question>;
    selectedOptions = (await Get.arguments["selectedOptions"] as List<Rx<Option>>).map((rxOption) => rxOption.value).toList();
    if (questions.isNotEmpty) {
      esepteu();
    } else {
      maxPoint.value = -1;
    }
    loading.value = false;
  }

  void esepteu() {
    int totalPoints = 0;
    int maximumPoints = 0;

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final option = selectedOptions[i];

      // Single choice (or Text sub-questions which are treated as single choice)
      if (question is SingleChoiceQuestion) {
        maximumPoints += 1;
        if (option is SingleChoiceOption) {
          if (option.selectedAnswer == question.correctAnswer) {
            totalPoints += 1;
          }
        }
      }
      // Matching questions: +1 for each correct sub-answer (max 2)
      else if (question is MatchingQuestion) {
        maximumPoints += 2;
        if (option is MatchingOption) {
          if (option.selectedFirstAnswer == question.subFirstQuestionAnswer) {
            totalPoints += 1;
          }
          if (option.selectedSecondAnswer == question.subSecondQuestionAnswer) {
            totalPoints += 1;
          }
        }
      }
      // Multiple choice questions: evaluate according to the detailed rules
      else if (question is MultipleChoiceQuestion) {
        maximumPoints += 2;
        if (option is MultipleChoiceOption) {
          // Create sets for easier comparison.
          final Set<String> correctSet = question.correctAnswers.toSet();
          final Set<String> selectedSet = option.selectedAnswers.toSet();

          // Count how many correct answers the user selected.
          int userCorrectCount = selectedSet.intersection(correctSet).length;
          // Count how many selected answers are not correct.
          int userWrongCount = selectedSet.difference(correctSet).length;
          // Total number of correct answers for this question.
          int numCorrect = correctSet.length;

          int score = 0;
          if (numCorrect == 1) {
            // For a task with 1 correct answer:
            if (userCorrectCount == 1 && userWrongCount == 0) {
              score = 2;
            } else if (userCorrectCount == 1 && userWrongCount == 1) {
              score = 1;
            } else {
              score = 0;
            }
          } else if (numCorrect == 2) {
            // For a task with 2 correct answers:
            if (userCorrectCount == 2 && userWrongCount == 0) {
              score = 2;
            } else if ((userCorrectCount == 1 && userWrongCount == 0) || (userCorrectCount == 1 && userWrongCount == 1) || (userCorrectCount == 2 && userWrongCount == 1)) {
              score = 1;
            } else {
              score = 0;
            }
          } else if (numCorrect == 3) {
            // For a task with 3 correct answers:
            if (userCorrectCount == 3 && userWrongCount == 0) {
              score = 2;
            } else if ((userCorrectCount == 2 && userWrongCount == 0) || (userCorrectCount == 2 && userWrongCount == 1) || (userCorrectCount == 3 && userWrongCount == 1)) {
              score = 1;
            } else {
              score = 0;
            }
          }
          totalPoints += score;
        }
      }
    }

    // Update the observable variables.
    resultPoint.value = totalPoints;
    maxPoint.value = maximumPoints;
    update();
  }
}
