import 'package:currency_converter/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';

class ErrorWidgetWithTryAgainButton extends StatelessWidget {
  final String errorMsg;

  final void Function() onTryAgain;

  const ErrorWidgetWithTryAgainButton({
    required this.errorMsg,
    required this.onTryAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMsg,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: onTryAgain,
          child: const Text(AppStrings.tryAgain),
        )
      ],
    );
  }
}
