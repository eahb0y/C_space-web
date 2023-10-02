import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String svgPicture;
  final Color borderColor;
  final bool borderState;

  const PaymentMethodWidget({
    super.key,
    required this.svgPicture,
    required this.borderColor,
    required this.borderState,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderState ? Colors.green : borderColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SvgPicture.asset(
        svgPicture,
        height: 24,
        width: 24,
      ),
    );
  }
}
