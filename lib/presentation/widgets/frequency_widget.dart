import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

class FrequencyWidget extends StatelessWidget {
  final int frequency;

  const FrequencyWidget({super.key, required this.frequency});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        color: Colors.amber,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Text(
        "Периодичность: $frequency",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: whiteColor,
            ),
      ),
    );
  }
}
