// File: lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/fuel_station/widgets/animated_station_info_window.dart';
import 'package:refuelety/components/map_view/cubit/map_cubit.dart';
import 'package:refuelety/core/app_service_locator.dart';
import 'package:refuelety/features/geo/cubit/manage_geo_cubit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (BuildContext context) => MapCubit(app<FuelService>()),
      child: const MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _mapController;
  LatLng userLocation = const LatLng(51.25, 9.77);

  void _onMapCreated(
    GoogleMapController controller,
    LatLng currentUserLocation,
  ) {
    _mapController = controller;
    context.read<MapCubit>().loadFuelStations(
          location: currentUserLocation,
        );
  }

  @override
  Widget build(BuildContext context) {
    final ManageGeoCubit geoCubit = context.read<ManageGeoCubit>();
    final MapCubit cubit = context.watch<MapCubit>();

    geoCubit.state.when(
      initial: () => null,
      loading: () => null,
      success: (_, Position? currentPosition) {
        if (currentPosition?.latitude == null ||
            currentPosition?.longitude == null) {
          return;
        }
        setState(() {
          userLocation = LatLng(
            currentPosition!.latitude,
            currentPosition.longitude,
          );
        });
      },
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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) => _onMapCreated(
              controller,
              userLocation,
            ),
            initialCameraPosition: CameraPosition(
              target: userLocation,
              zoom: 15,
            ),
            markers: cubit.state.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: (_) => cubit.selectStation(null),
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
          // Wir zeigen das AnimatedStationInfoWindow immer an,
          // kontrollieren aber die Sichtbarkeit über die isVisible-Property
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
}
