import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/question/option_model.dart';
import '../models/question/question_model.dart';
import '../screens/result/result.dart';

class TestController extends GetxController {
  static TestController get instance => Get.find();

  final questionId = 0.obs;
  final singleQuestionLength = 0.obs;
  ScrollController scrollController = ScrollController();
  late List<Question> questions;
  final showQuestions = <Question>[].obs;
  final selectedOptions = <Rx<Option>>[];
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
    questions = Get.arguments as List<Question>;
    for (final q in questions) {
      if (q.type == 'single_choice') {
        singleQuestionLength.value++;
        showQuestions.add(q as SingleChoiceQuestion);
        selectedOptions.add(SingleChoiceOption(selectedAnswer: '', options: (q).options).obs);
      } else if (q.type == 'text_question') {
        for (final q1 in (q as TextQuestion).questions) {
          showQuestions.add(q1.copyWith(text: q.text, textImage: q.textImage));
          selectedOptions.add(SingleChoiceOption(selectedAnswer: '', options: q1.options).obs);
        }
      } else if (q.type == 'matching') {
        showQuestions.add(q as MatchingQuestion);
        selectedOptions.add(MatchingOption(selectedFirstAnswer: '', selectedSecondAnswer: '', options: (q).options).obs);
      } else {
        showQuestions.add(q as MultipleChoiceQuestion);
        selectedOptions.add(MultipleChoiceOption(selectedAnswers: [], options: (q).options).obs);
      }
    }
    loading.value = false;
  }

  void changeQuestion(int index) {
    questionId.value = index;
    scrollToIndex(index);
  }

  void scrollToIndex(int index) {
    double screenWidth = Get.width;
    double itemWidth = 45.h;
    double centerPosition = (index * itemWidth) - screenWidth / 2 + itemWidth / 2;
    double maxScrollExtent = scrollController.position.maxScrollExtent;
    if (index == 0) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (index == showQuestions.length - 1) {
      scrollController.animateTo(
        maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      double scrollPosition = min(maxScrollExtent, max(0, centerPosition));
      scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextQuestion() {
    if (showQuestions.length > questionId.value + 1) {
      questionId.value++;
      scrollToIndex(questionId.value);
    }
  }

  void prevQuestion() {
    if (0 < questionId.value) {
      questionId.value--;
      scrollToIndex(questionId.value);
    }
  }

  BoxDecoration buildDecoration(BuildContext context, int index) {
    if (questionId.value == index) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepOrange,
      );
    }

    final option = selectedOptions[index].value;

    if (option is SingleChoiceOption) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: option.selectedAnswer.isEmpty ? Theme.of(context).colorScheme.surface : Colors.lightBlue,
        border: option.selectedAnswer.isEmpty ? Border.all(color: Theme.of(context).unselectedWidgetColor) : null,
      );
    } else if (option is MultipleChoiceOption) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: option.selectedAnswers.isEmpty ? Theme.of(context).colorScheme.surface : Colors.lightBlue,
        border: option.selectedAnswers.isEmpty ? Border.all(color: Theme.of(context).unselectedWidgetColor) : null,
      );
    } else if (option is MatchingOption) {
      final first = option.selectedFirstAnswer;
      final second = option.selectedSecondAnswer;

      if (first.isNotEmpty && second.isNotEmpty) {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightBlue,
        );
      } else if (first.isEmpty && second.isEmpty) {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Theme.of(context).unselectedWidgetColor),
        );
      } else {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.lightBlue,
              Colors.white,
            ],
            tileMode: TileMode.clamp,
            begin: Alignment.topLeft,
            end: Alignment(0.1, 0.1),
          ),
          border: Border.all(color: Colors.lightBlue),
        );
      }
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).colorScheme.surface,
      border: Border.all(color: Theme.of(context).unselectedWidgetColor),
    );
  }

  Widget buildNumberText(BuildContext context, int index) {
    final option = selectedOptions[index].value;
    final bool isActive = questionId.value == index;
    TextStyle style;

    if (isActive) {
      style = const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
    } else if (option is SingleChoiceOption) {
      style = option.selectedAnswer.isNotEmpty
          ? const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )
          : const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            );
    } else if (option is MatchingOption) {
      final bool firstNotEmpty = option.selectedFirstAnswer.isNotEmpty;
      final bool secondNotEmpty = option.selectedSecondAnswer.isNotEmpty;

      if (firstNotEmpty && secondNotEmpty) {
        style = const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      } else {
        style = const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        );
      }
    } else if (option is MultipleChoiceOption) {
      style = option.selectedAnswers.isNotEmpty
          ? const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )
          : const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            );
    } else {
      style = const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
    }

    final textWidget = Text(
      '${index + 1}',
      style: style,
    );

    return Center(
      child: textWidget,
    );
  }

  void selectOption(String tappedAnswer, int index) {
    final currentOption = selectedOptions[index].value;

    if (currentOption is SingleChoiceOption) {
      selectedOptions[index].value = SingleChoiceOption(
        options: currentOption.options,
        selectedAnswer: tappedAnswer,
      );
    } else if (currentOption is MultipleChoiceOption) {
      final List<String> selected = List.from(currentOption.selectedAnswers);
      if (selected.contains(tappedAnswer)) {
        selected.remove(tappedAnswer);
      } else {
        selected.add(tappedAnswer);
      }
      selectedOptions[index].value = MultipleChoiceOption(
        options: currentOption.options,
        selectedAnswers: selected,
      );
    } else if (currentOption is MatchingOption) {
      String first = currentOption.selectedFirstAnswer;
      String second = currentOption.selectedSecondAnswer;

      if (first.isEmpty) {
        first = tappedAnswer;
      } else if (first == tappedAnswer) {
        first = '';
      } else if (second.isEmpty) {
        second = tappedAnswer;
      } else if (second == tappedAnswer) {
        second = '';
      } else {
        second = tappedAnswer;
      }

      selectedOptions[index].value = MatchingOption(
        options: currentOption.options,
        selectedFirstAnswer: first,
        selectedSecondAnswer: second,
      );
    }
  }

  void endQuiz() {
    Get.off(() => const ResultPage(), arguments: {"questions": showQuestions, "selectedOptions": selectedOptions});
  }

  Future<bool> showEndDialog() async {
    final random = Random();
    final int a = random.nextInt(4) + 1; // Random number between 1 and 4.
    final int b = random.nextInt(4) + 1;
    final int correctAnswer = a + b;

    final bool solvedCorrectly = await showDialog<bool>(
          context: Get.context!,
          barrierDismissible: false,
          builder: (dialogContext) {
            String userInput = '';
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text(
                    'Тестілеуді аяқтауды растаңыз:',
                    style: TextStyle(fontSize: 20),
                  ), // "Confirm quiz finish"
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Қарапайым мысалды шешіңіз: $a + $b = ?'),
                      const SizedBox(height: 10),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          userInput = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Жауапты енгізіңіз', // "Enter your answer"
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Болдырмау'), // "Cancel"
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (int.tryParse(userInput) == correctAnswer) {
                          Navigator.of(context).pop(true);
                        } else {
                          // Show an error message if the answer is wrong.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Қате жауап!')), // "Wrong answer!"
                          );
                        }
                      },
                      child: const Text('Жіберу'), // "Submit"
                    ),
                  ],
                );
              },
            );
          },
        ) ??
        false;

    if (solvedCorrectly) {
      endQuiz();
    }
    return solvedCorrectly;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
