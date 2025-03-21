import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/components/fuel_station/widgets/animated_station_info_window.dart';
import 'package:refuelety/components/map_view/cubit/map_cubit.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageGeoCubit geoCubit = context.watch<ManageGeoCubit>();
    return BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(
        geoCubit: geoCubit,
      ),
      child: MapView(),
    );
  }
}

// ignore: must_be_immutable
class MapView extends StatelessWidget {
  MapView({
    super.key,
  });

  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final MapCubit cubit = context.watch<MapCubit>();

    // TODO: outsource this to none widget component
    cubit.geoCubit.state.when(
      initial: () => null,
      loading: () => null,
      success: cubit.updateUserPosition,
      permissionDenied: () => null,
      error: (String error) => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tankstellen Map'),
        elevation: 2,
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () => GoRouter.of(context).goNamed('stations'),
            tooltip: 'Zur Listenansicht wechseln',
          ),
        ],
      ),
      body: cubit.state.userPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) =>
                      _onMapCreated(
                    controller,
                    // TODO: check for not null
                    cubit.state.userPosition!,
                    cubit.loadFuelStations,
                  ),
                  initialCameraPosition: CameraPosition(
                    // TODO: check for not null
                    target: cubit.state.userPosition!,
                    zoom: 15,
                  ),
                  markers: cubit.state.markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                if (cubit.state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (cubit.state.error != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cubit.state.error!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                if (cubit.state.selectedStation != null)
                  AnimatedStationInfoWindow(
                    station: cubit.state.selectedStation!,
                    isVisible: cubit.state.selectedStation != null,
                    onClose: () => context.read<MapCubit>().selectStation(null),
                  ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.getVisibleRegion().then((LatLngBounds bounds) {
            final LatLng center = LatLng(
              (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
              (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
            );
            cubit.loadFuelStations(location: center);
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> _onMapCreated(
    GoogleMapController controller,
    LatLng currentUserLocation,
    Future<void> Function({required LatLng location}) loadFuelStations,
  ) async {
    _mapController = controller;
    await loadFuelStations(
      location: currentUserLocation,
    );
  }
}

class MapViewContent extends StatelessWidget {
  const MapViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
