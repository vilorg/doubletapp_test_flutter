// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:doubletapp_habits/data/models/habbit_model.dart';

class TypeHabbitWidget extends StatelessWidget {
  final TypeHabbit typeHabbit;

  const TypeHabbitWidget({
    Key? key,
    required this.typeHabbit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        color: typeHabbit == TypeHabbit.good ? greenColor : redColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Text(
        typeHabbit == TypeHabbit.good
            ? "Полезная привычка"
            : "Вредная привычка",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: whiteColor,
            ),
      ),
    );
  }
}
