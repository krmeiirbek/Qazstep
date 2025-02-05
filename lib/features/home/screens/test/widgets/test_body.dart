import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../controllers/test_controller.dart';
import '../../../models/question/question_model.dart';
import 'matched_questions.dart';
import 'option_item.dart';
import 'text_question.dart';

class TestBody extends GetView<TestController> {
  const TestBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() {
          final question = controller.showQuestions[controller.questionId.value];
          Widget imageWidget = const SizedBox.shrink();
          String displayText = '';
          String? bigText;
          Widget bigTextImageWidget = const SizedBox.shrink();
          String matchedFirst = '';
          String matchedSecond = '';
          if (question is SingleChoiceQuestion) {
            displayText = question.questionText;
            // options = question.options;
            bigText = question.text;
            if (question.questionImage != null && question.questionImage!.isNotEmpty) {
              imageWidget = SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.network(
                  question.questionImage!,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              );
            }
            if (question.textImage != null && question.textImage!.isNotEmpty) {
              bigTextImageWidget = SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.network(
                  question.textImage!,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              );
            }
          } else if (question is MatchingQuestion) {
            displayText = question.questionText;
            matchedFirst = question.subFirstQuestion;
            matchedSecond = question.subSecondQuestion;
            if (question.questionImage != null && question.questionImage!.isNotEmpty) {
              imageWidget = SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.network(
                  question.questionImage!,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              );
            }
          } else if (question is MultipleChoiceQuestion) {
            displayText = question.questionText;
            if (question.questionImage != null && question.questionImage!.isNotEmpty) {
              imageWidget = SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.network(
                  question.questionImage!,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              );
            }
          }

          return Padding(
            padding: EdgeInsets.all(24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bigText != null ? TextQuestionWidget(bigTextImageWidget: bigTextImageWidget, bigText: bigText) : Container(),
                imageWidget,
                SizedBox(height: 8.h),
                GptMarkdown('**${controller.questionId.value + 1}**. $displayText', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 4.h),
                matchedFirst.isNotEmpty && matchedSecond.isNotEmpty ? MatchedQuestions(matchedFirst: matchedFirst, matchedSecond: matchedSecond) : Container(),
                ...controller.selectedOptions[controller.questionId.value].value.options.map((optionString) => OptionItem(optionString: optionString)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
