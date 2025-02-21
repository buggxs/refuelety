import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';

void main() {
  // Register services and logging
  setup();

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement routing
    return BlocProvider<ManageGeoCubit>(
      create: (BuildContext context) => ManageGeoCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TestCubit(),
      ),
    );
  }
}

class TestCubit extends StatefulWidget {
  const TestCubit({super.key});

  @override
  State<TestCubit> createState() => _TestCubitState();
}

class _TestCubitState extends State<TestCubit> {
  @override
  void initState() {
    context.read<ManageGeoCubit>().fetchPositionStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ManageGeoCubit cubit = context.watch<ManageGeoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: cubit.state.when(
          initial: () => const Text('Initial'),
          loading: () => const CircularProgressIndicator(),
          success: (Stream<Position> position) {
            return StreamBuilder<Position>(
              stream: position,
              builder:
                  (BuildContext context, AsyncSnapshot<Position> snapshot) {
                return Text('Position: ${snapshot.data}');
              },
            );
          },
          permissionDenied: () => const Text('Permission Denied'),
          error: (String message) => Text('Error: $message'),
        ),
      ),
    );
  }
}
