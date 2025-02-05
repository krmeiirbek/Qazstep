import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../controllers/test_controller.dart';
import '../../../models/question/option_model.dart';

class OptionItem extends GetView<TestController> {
  const OptionItem({
    super.key,
    required this.optionString,
  });

  final String optionString;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the current reactive Option object.
      final currentOption = controller.selectedOptions[controller.questionId.value].value;

      // Determine if this option should be shown as selected.
      bool isSelected = false;
      if (currentOption is SingleChoiceOption) {
        isSelected = (currentOption.selectedAnswer == optionString);
      } else if (currentOption is MultipleChoiceOption) {
        isSelected = currentOption.selectedAnswers.contains(optionString);
      } else if (currentOption is MatchingOption) {
        isSelected = (currentOption.selectedFirstAnswer == optionString || currentOption.selectedSecondAnswer == optionString);
      }

      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          // Pass the option string and question index.
          controller.selectOption(optionString, controller.questionId.value);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            // Use the primary color if selected.
            color: currentOption.runtimeType == MatchingOption
                ? (currentOption as MatchingOption).selectedFirstAnswer == optionString
                    ? Colors.green
                    : currentOption.selectedSecondAnswer == optionString
                        ? Colors.pink
                        : null
                : isSelected
                    ? Colors.blue
                    : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: GptMarkdown(optionString),
        ),
      );
    });
  }
}
