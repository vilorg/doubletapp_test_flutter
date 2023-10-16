import 'package:auto_route/auto_route.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/presentation/pages/detail_habbit_item_screen.dart';
import 'package:doubletapp_habits/presentation/pages/list_of_habbits_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ListOfHabbitsRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: DetailHabbitItemRoute.page,
        ),
      ];
}
