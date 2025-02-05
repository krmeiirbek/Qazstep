import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextQuestionWidget extends StatelessWidget {
  const TextQuestionWidget({
    super.key,
    required this.bigTextImageWidget,
    required this.bigText,
  });

  final Widget bigTextImageWidget;
  final String? bigText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bigTextImageWidget,
        SizedBox(height: 8.h),
        Text(
          bigText ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
