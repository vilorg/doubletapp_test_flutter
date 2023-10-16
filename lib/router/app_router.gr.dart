// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailHabbitItemRoute.name: (routeData) {
      final args = routeData.argsAs<DetailHabbitItemRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailHabbitItemPage(
          key: args.key,
          habbit: args.habbit,
          parentContext: args.parentContext,
        ),
      );
    },
    ListOfHabbitsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListOfHabbitsScreen(),
      );
    },
  };
}

/// generated route for
/// [DetailHabbitItemPage]
class DetailHabbitItemRoute extends PageRouteInfo<DetailHabbitItemRouteArgs> {
  DetailHabbitItemRoute({
    Key? key,
    HabbitModel? habbit,
    required BuildContext parentContext,
    List<PageRouteInfo>? children,
  }) : super(
          DetailHabbitItemRoute.name,
          args: DetailHabbitItemRouteArgs(
            key: key,
            habbit: habbit,
            parentContext: parentContext,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailHabbitItemRoute';

  static const PageInfo<DetailHabbitItemRouteArgs> page =
      PageInfo<DetailHabbitItemRouteArgs>(name);
}

class DetailHabbitItemRouteArgs {
  const DetailHabbitItemRouteArgs({
    this.key,
    this.habbit,
    required this.parentContext,
  });

  final Key? key;

  final HabbitModel? habbit;

  final BuildContext parentContext;

  @override
  String toString() {
    return 'DetailHabbitItemRouteArgs{key: $key, habbit: $habbit, parentContext: $parentContext}';
  }
}

/// generated route for
/// [ListOfHabbitsScreen]
class ListOfHabbitsRoute extends PageRouteInfo<void> {
  const ListOfHabbitsRoute({List<PageRouteInfo>? children})
      : super(
          ListOfHabbitsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListOfHabbitsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
