import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/fuel_station/cubit/fuel_station_cubit.dart';
import 'package:refuelety/components/fuel_station/widgets/fuel_station_card.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';

class FuelStationListScreen extends StatelessWidget {
  const FuelStationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FuelStationCubit>(
      create: (BuildContext context) => FuelStationCubit(
        geoCubit: context.read<ManageGeoCubit>(),
      ),
      child: const FuelStationListScreenContent(),
    );
  }
}

class FuelStationListScreenContent extends StatelessWidget {
  const FuelStationListScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FuelStationCubit cubit = context.watch<FuelStationCubit>();

    Widget child = const SizedBox();

    if (cubit.state is FuelStationInitial) {
      child = const Center(child: CircularProgressIndicator());
    }

    if (cubit.state is FuelStationLoading) {
      child = const Center(child: CircularProgressIndicator());
    }

    if (cubit.state case final FuelStationLoaded loadedState) {
      if (loadedState.fuelStations.stations?.isEmpty ?? true) {
        child = const Center(child: Text('Keine Tankstellen gefunden'));
      } else {
        child = ListView.builder(
          itemCount: loadedState.fuelStations.stations!.length,
          itemBuilder: (_, int index) {
            final FuelStation station =
                loadedState.fuelStations.stations![index];
            return FuelStationCard(station: station);
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tankstellen Übersicht'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => GoRouter.of(context).goNamed('map'),
            tooltip: 'Zur Kartenansicht wechseln',
          ),
        ],
      ),
      body: child,
    );
  }
}
