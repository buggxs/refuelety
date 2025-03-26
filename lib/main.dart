import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/core/router.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';
import 'package:refuelety/misc/app_theme.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement routing
    return BlocProvider<ManageGeoCubit>(
      create: (BuildContext context) => ManageGeoCubit()..getCurrentPosition(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: AppTheme().light(),
        darkTheme: AppTheme().dark(),
        routerConfig: router,
      ),
    );
  }
}
