import 'package:flutter/material.dart';

class TotalTimeRowWidget extends StatelessWidget {
  final String label;
  final String text;

  const TotalTimeRowWidget(
      {super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
