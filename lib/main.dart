import 'package:doubletapp_habits/core/platform/network_info.dart';
import 'package:doubletapp_habits/data/datasources/local_data_source.dart';
import 'package:doubletapp_habits/data/datasources/remote_data_source.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:doubletapp_habits/data/repository/repository_impl.dart';
import 'package:doubletapp_habits/domain/repository/repository.dart';
import 'package:doubletapp_habits/router/app_router.dart';
import 'package:doubletapp_habits/shared/constants.dart';
import 'package:doubletapp_habits/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<HabbitModel>(HabbitModelAdapter());
  Hive.registerAdapter<TypeHabbit>(TypeHabbitAdapter());
  Hive.registerAdapter<Priorety>(PrioretyAdapter());
  await Hive.openBox<HabbitModel>(habbitsBoxName);

  GetIt.I.registerSingleton<Repository>(RepositoryImpl(
    localDataSource: LocalDataSourceImpl(),
    networkInfo: NetworkInfoImp(InternetConnectionChecker()),
    remoteDataSource: RemoteDataSourceImpl(client: http.Client()),
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp.router(
        title: 'Thailand app',
        theme: themeApp,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
