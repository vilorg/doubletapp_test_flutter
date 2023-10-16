// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:doubletapp_habits/presentation/bloc_habbit/habbit_bloc.dart';
import 'package:doubletapp_habits/presentation/widgets/frequency_widget.dart';
import 'package:doubletapp_habits/presentation/widgets/priorety_widget.dart';
import 'package:doubletapp_habits/presentation/widgets/type_habbit_widget.dart';
import 'package:doubletapp_habits/router/app_router.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HabbitItemWidget extends StatelessWidget {
  final HabbitModel habbit;

  const HabbitItemWidget({
    Key? key,
    required this.habbit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () => AutoRouter.of(context).push(
              DetailHabbitItemRoute(habbit: habbit, parentContext: context)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              boxShadow: shadow,
              color: whiteColor,
            ),
            margin: const EdgeInsets.only(top: defaultPaddingInt),
            padding: defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habbit.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                defaultSmalSpacer,
                Wrap(
                  spacing: smalSpacerInt,
                  runSpacing: smalSpacerInt,
                  children: [
                    TypeHabbitWidget(typeHabbit: habbit.type),
                    PrioretyWidget(priorety: habbit.priority),
                    FrequencyWidget(frequency: habbit.frequency),
                  ],
                ),
                defaultSmalSpacer,
                Text(
                  habbit.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                defaultSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                          initDateTime.add(Duration(seconds: habbit.date))),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text("Привычка выполнена?",
                        style: Theme.of(context).textTheme.bodySmall),
                    defaultSmalSpacer,
                    SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: IconButton.filled(
                        onPressed: () => context
                            .read<HabbitBloc>()
                            .add(HabbitDoneEvent(habbit: habbit)),
                        icon: const Icon(Icons.check),
                        style: ButtonStyle(
                          iconSize: MaterialStateProperty.all<double>(25),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(darkOrangeColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: defaultBorderRadius,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () =>
              context.read<HabbitBloc>().add(HabbitDeleteEvent(habbit: habbit)),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: redColor,
            ),
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(3),
            child: const Icon(
              Icons.close,
              color: whiteColor,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
