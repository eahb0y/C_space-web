import 'package:c_space_web/core/theme/colors/app_colors.dart';
import 'package:c_space_web/core/theme/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class TotalSumWidget extends StatelessWidget {
  final int totalSum;

  const TotalSumWidget({
    super.key,
    required this.totalSum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Время работы:",
          style: AppTextStyle.workTime,
        ),
        const SizedBox(height: 20),
        Center(
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: LightColorTheme.startTimeBackGround,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: LightColorTheme.buttonBackgroundColor,
              ),
            ),
            child: Text(
              "$totalSum",
              style: const TextStyle(
                color: LightColorTheme.buttonBackgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
