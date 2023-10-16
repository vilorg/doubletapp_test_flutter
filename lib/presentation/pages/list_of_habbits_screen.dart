// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:doubletapp_habits/presentation/bloc_habbit/habbit_bloc.dart';
import 'package:doubletapp_habits/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:doubletapp_habits/core/platform/capitalize.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/presentation/widgets/draggable_filter_widget.dart';
import 'package:doubletapp_habits/presentation/widgets/habbit_item_widget.dart';
import 'package:doubletapp_habits/shared/constants.dart';

@RoutePage()
class ListOfHabbitsScreen extends StatefulWidget {
  const ListOfHabbitsScreen({super.key});

  @override
  State<ListOfHabbitsScreen> createState() => _ListOfHabbitsScreenState();
}

class _ListOfHabbitsScreenState extends State<ListOfHabbitsScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isDateFilter = false;
  String search = "";

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    List<HabbitModel> habbits = [];

    return BlocProvider(
      create: (context) => HabbitBloc()..add(HabbitInitEvent()),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  DateFormat.yMMMEd("ru").format(DateTime.now()).capitalize()),
              bottom: const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.thumb_up),
                    text: "Полезные привычки",
                  ),
                  Tab(
                    icon: Icon(Icons.thumb_down),
                    text: "Вредные привычки",
                  ),
                ],
              ),
            ),
            body: BlocListener<HabbitBloc, HabbitState>(
              listener: (context, state) {
                if (state is HabbitLoadedState) {
                  if (state.message != null) {
                    Future.microtask(
                      () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
              child: Stack(
                children: [
                  BlocBuilder<HabbitBloc, HabbitState>(
                    builder: (context, state) {
                      if (state is HabbitLoadingState) {  
                        isLoading = true;
                      } else if (state is HabbitLoadedState) {
                        habbits = state.habbits;
                        habbits = habbits
                            .where((habbit) => habbit.title
                                .toLowerCase()
                                .startsWith(search.toLowerCase()))
                            .toList();
                        if (isDateFilter) {
                          habbits.sort((a, b) => a.date.compareTo(b.date));
                        } else {
                          habbits.sort((a, b) => a.title.compareTo(b.title));
                        }
                        isLoading = false;
                      } else if (state is HabbitResetState) {
                        context.read<HabbitBloc>().add(HabbitInitEvent());
                      }
                      return isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: darkOrangeColor),
                            )
                          : TabBarView(
                              children: [
                                _ListHabbitsCategoryWidget(
                                  habbits: habbits
                                      .where((habbit) =>
                                          habbit.type == TypeHabbit.good)
                                      .toList(),
                                ),
                                _ListHabbitsCategoryWidget(
                                  habbits: habbits
                                      .where((habbit) =>
                                          habbit.type == TypeHabbit.bad)
                                      .toList(),
                                ),
                              ],
                            );
                    },
                  ),
                  DraggableFilterWidget(
                    controller: searchController,
                    onChangeSearch: (value) => setState(() => search = value),
                    isDateFilter: isDateFilter,
                    onChangeSorting: (value) =>
                        setState(() => isDateFilter = value ?? false),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => AutoRouter.of(context).push(
                DetailHabbitItemRoute(parentContext: context),
              ),
              child: const Icon(Icons.add),
            ),
          );
        }),
      ),
    );
  }
}

class _ListHabbitsCategoryWidget extends StatelessWidget {
  final List<HabbitModel> habbits;

  const _ListHabbitsCategoryWidget({
    Key? key,
    required this.habbits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: defaultPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ваши привычки",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ...habbits.map((habbit) => HabbitItemWidget(habbit: habbit)).toList(),
          habbits.isEmpty
              ? Center(
                  child: Padding(
                    padding: defaultPadding,
                    child: Text(
                      "Здесь ничего нет...",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}
