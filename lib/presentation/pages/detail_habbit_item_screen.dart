// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:doubletapp_habits/presentation/bloc_detail_habbit/detail_habbit_bloc.dart';
import 'package:doubletapp_habits/presentation/bloc_habbit/habbit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/shared/constants.dart';

@RoutePage()
class DetailHabbitItemPage extends StatefulWidget {
  final HabbitModel? habbit;
  final BuildContext parentContext;

  const DetailHabbitItemPage({
    Key? key,
    this.habbit,
    required this.parentContext,
  }) : super(key: key);

  @override
  State<DetailHabbitItemPage> createState() => _DetailHabbitItemPageState();
}

class _DetailHabbitItemPageState extends State<DetailHabbitItemPage> {
  TextEditingController titleContrroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TypeHabbit typeHabbit = TypeHabbit.good;

  String priority = "Средний";

  final List<String> list = ["Низкий", "Средний", "Высокий"];

  @override
  void initState() {
    super.initState();
    if (widget.habbit != null) {
      titleContrroller = TextEditingController(text: widget.habbit!.title);
      descriptionController =
          TextEditingController(text: widget.habbit!.description);
      countController =
          TextEditingController(text: widget.habbit!.count.toString());
      frequencyController =
          TextEditingController(text: widget.habbit!.frequency.toString());
      priority = list[widget.habbit!.priority.index];
      typeHabbit = widget.habbit!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailHabbitBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.habbit != null
              ? "Редактирование привычки"
              : "Создание привычки"),
        ),
        body: SingleChildScrollView(
          padding: defaultPadding,
          child: BlocBuilder<DetailHabbitBloc, DetailHabbitState>(
            builder: (context, state) {
              String? error;
              bool isLoading = false;
              if (state is HabbitDetailSuccesState) {
                widget.parentContext.read<HabbitBloc>().add(HabbitInitEvent());
                AutoRouter.of(context).pop();
              } else if (state is HabbitDetailLoadingState) {
                isLoading = true;
              } else if (state is HabbitDetailLoadedState) {
                error = state.error;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Название привычки:",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  defaultSmalSpacer,
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: titleContrroller,
                    enabled: !isLoading,
                    decoration:
                        const InputDecoration(hintText: "Название привычки"),
                  ),
                  defaultSpacer,
                  Text(
                    "Описание привычки:",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  defaultSmalSpacer,
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: descriptionController,
                    enabled: !isLoading,
                    decoration:
                        const InputDecoration(hintText: "Описание привычки"),
                  ),
                  defaultSpacer,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Приоритет привычки:",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            defaultSmalSpacer,
                            DropdownButton<String>(
                              value: priority,
                              elevation: 16,
                              style: Theme.of(context).textTheme.bodyMedium,
                              iconEnabledColor: darkOrangeColor,
                              underline: Container(
                                height: 1,
                                color: darkOrangeColor,
                              ),
                              onChanged: isLoading
                                  ? null
                                  : (String? value) {
                                      setState(() => priority = value!);
                                    },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      defaultSpacer,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Тип привычки:",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            defaultSmalSpacer,
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Хорошая привычка'),
                              leading: Radio<TypeHabbit>(
                                value: TypeHabbit.good,
                                groupValue: typeHabbit,
                                onChanged: isLoading
                                    ? null
                                    : (TypeHabbit? value) {
                                        setState(() {
                                          typeHabbit = value!;
                                        });
                                      },
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Плохая привычка'),
                              leading: Radio<TypeHabbit>(
                                value: TypeHabbit.bad,
                                groupValue: typeHabbit,
                                onChanged: isLoading
                                    ? null
                                    : (TypeHabbit? value) {
                                        setState(() {
                                          typeHabbit = value!;
                                        });
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  defaultSpacer,
                  Text(
                    "Количество/ периодичность (в днях)",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  defaultSmalSpacer,
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: !isLoading,
                            controller: countController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: "Кол-во"),
                          ),
                        ),
                        defaultSpacer,
                        Expanded(
                          child: TextField(
                            enabled: !isLoading,
                            controller: frequencyController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: "П-сть"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  defaultSpacer,
                  defaultSpacer,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => context
                              .read<DetailHabbitBloc>()
                              .add(HabbitDetailSaveEvent(
                                titleContrroller.text,
                                descriptionController.text,
                                typeHabbit,
                                Priorety.values.firstWhere((element) =>
                                    element.index == list.indexOf(priority)),
                                countController.text,
                                frequencyController.text,
                                widget.habbit == null ? "" : widget.habbit!.uid,
                              )),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            )
                          : Text(
                              "Сохранить!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: whiteColor,
                                  ),
                            ),
                    ),
                  ),
                  defaultSpacer,
                  error == null
                      ? const SizedBox()
                      : Text(
                          error,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: redColor,
                                  ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
