// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:doubletapp_habits/data/models/habbit_model.dart';

class PrioretyWidget extends StatelessWidget {
  final Priorety priorety;

  const PrioretyWidget({
    Key? key,
    required this.priorety,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = whiteColor;
    String text = "";

    switch (priorety) {
      case Priorety.high:
        backgroundColor = darkOrangeColor;
        text = "Высокий приоритет";
        break;
      case Priorety.medium:
        backgroundColor = lightOrangeColor;
        text = "Средний приоритет";
        break;
      case Priorety.low:
        backgroundColor = greyColor;
        text = "Низкий приоритет";
        break;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: whiteColor,
            ),
      ),
    );
  }
}
