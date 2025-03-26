import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/fuel_station/cubit/fuel_station_cubit.dart';
import 'package:refuelety/components/fuel_station/widgets/fuel_station_card.dart';
import 'package:refuelety/components/fuel_station/widgets/fuel_station_filter.dart';
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

    Widget content = const SizedBox();

    if (cubit.state is FuelStationInitial) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (cubit.state is FuelStationLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (cubit.state case final FuelStationLoaded loadedState) {
      final List<FuelStation>? filteredStations =
          loadedState.fuelStations.stations;
      if (loadedState.fuelStations.stations?.isEmpty ?? true) {
        content = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.local_gas_station_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Keine Tankstellen gefunden',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Versuche den Suchradius zu vergrößern\noder '
                'andere Filter zu wählen',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ],
          ),
        );
      } else {
        content = ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          itemCount: filteredStations!.length,
          itemBuilder: (_, int index) {
            final FuelStation station = filteredStations[index];
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
      body: Column(
        children: <Widget>[
          // Filter-Widget
          FuelStationFilter(
            radius: cubit.state.searchRadius,
            onRadiusChanged: cubit.onRadiusChanged,
            selectedFuelType: cubit.state.selectedFuelType,
            onFuelTypeSelected: cubit.onFuelTypeSelected,
          ),

          // Liste der Tankstellen
          Expanded(child: content),
        ],
      ),
    );
  }
}
