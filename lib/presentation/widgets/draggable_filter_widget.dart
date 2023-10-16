import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';

class DraggableFilterWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChangeSearch;
  final bool isDateFilter;
  final Function(bool?) onChangeSorting;

  const DraggableFilterWidget({
    super.key,
    required this.controller,
    required this.onChangeSearch,
    required this.isDateFilter,
    required this.onChangeSorting,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.6,
      expand: true,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: ColoredBox(
            color: greyColor,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: defaultPadding,
                decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: defaultBorderRadius,
                        color: lightOrangeColor,
                      ),
                    ),
                    defaultSpacer,
                    Text(
                      "Фильтр",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: whiteColor,
                          ),
                    ),
                    defaultSpacer,
                    defaultSpacer,
                    defaultSpacer,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Поиск по названию привычки:",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "Поиск"),
                      controller: controller,
                      onChanged: onChangeSearch,
                    ),
                    defaultSpacer,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Сортировка привычек:",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'По умолчанию',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: isDateFilter,
                        onChanged: onChangeSorting,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'По дате создания',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: isDateFilter,
                        onChanged: onChangeSorting,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
