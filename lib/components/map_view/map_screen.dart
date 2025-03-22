// File: lib/screens/map_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:refuelety/api/api.dart';
import 'package:refuelety/components/map_view/cubit/map_cubit.dart';
import 'package:refuelety/components/map_view/widgets/fuel_price_card.dart';
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
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future<void> _onMapCreated(
    GoogleMapController controller,
    LatLng currentUserLocation,
  ) async {
    _mapController.complete(controller);

    context.read<MapCubit>().loadFuelStations(
          location: currentUserLocation,
        );
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  @override
  Widget build(BuildContext context) {
    final ManageGeoCubit geoCubit = context.read<ManageGeoCubit>();
    final MapCubit cubit = context.watch<MapCubit>();

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
          geoCubit.state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (Stream<Position>? positionStream, _) {
              return StreamBuilder<Position>(
                stream: positionStream,
                builder:
                    (BuildContext context, AsyncSnapshot<Position> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Fehler beim Laden der Position'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Keine Position verfügbar'),
                    );
                  }
                  final LatLng userPosition = LatLng(
                    snapshot.data!.latitude,
                    snapshot.data!.longitude,
                  );
                  // Move camera to the new position
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _moveCamera(userPosition);
                  });

                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) =>
                        _onMapCreated(
                      controller,
                      userPosition,
                    ),
                    initialCameraPosition: CameraPosition(
                      target: userPosition,
                      zoom: 15,
                    ),

                    markers: cubit.state.markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,

                    // onTap: (_) => cubit.selectStation(null),
                    // onTap: (_) {
                    //   final FuelStation? selectedStation =
                    //       cubit.state.selectedStation;
                    //   showBottomSheet2(
                    //     context,
                    //     selectedStation!,
                    //   );
                    // },
                  );
                },
              );
            },
            permissionDenied: () => const Center(
              child: Text('Keine Berechtigung für Standortzugriff'),
            ),
            error: (String error) => Center(
              child: Text('Fehler beim Standortzugriff: $error'),
            ),
          ),

          Positioned(
            right: 10,
            top: 50,
            child: IconButton.filled(
              onPressed: () {
                final FuelStation fuelStation = FuelStation(
                  id: '1',
                  name: 'Shell Tankstelle',
                  place: 'Musterstadt',
                  dist: 1.5,
                  e5: 1.73,
                  e10: 1.71,
                  diesel: 1.55,
                  isOpen: true,
                  brand: 'Shell',
                  street: 'Musterstraße ',
                  houseNumber: '1',
                  postCode: 55345,
                  lat: 48.123456,
                  lng: 11.123456,
                );
                showBottomSheet2(
                  context,
                  fuelStation,
                );
              },
              icon: const Icon(Icons.search),
            ),
          ),
          Positioned(
            right: 10,
            top: 100,
            child: IconButton.filled(
              onPressed: () => context.goNamed('filter'),
              icon: const Icon(Icons.tune),
            ),
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
          // s
          // AnimatedStationInfoWindow(
          //   station: cubit.state.selectedStation!,
          //   isVisible: cubit.state.selectedStation != null,
          //   onClose: () => context.read<MapCubit>().selectStation(null),
          // ),
        ],
      ),
    );
  }
}

void showBottomSheet2(
  BuildContext context,
  FuelStation station,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    width: 70,
                    fit: BoxFit.cover,
                    'https://www.designenlassen.de/blog/wp-content/uploads/2024/03/Shell.png',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${station.name}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${station.place}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${station.dist} km',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  FuelPriceCard(
                    fuelType: 'Benzin',
                    price: station.e5 ?? 0,
                    isIncrease: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FuelPriceCard(
                    fuelType: 'Super E10',
                    price: station.e10 ?? 0,
                    isIncrease: false,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FuelPriceCard(
                    fuelType: 'Diesel',
                    price: station.diesel ?? 0,
                    isIncrease: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    size: 40,
                    Icons.location_on_outlined,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${station.street} ${station.houseNumber}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(),
                      ),
                      Text(
                        '${station.postCode} ${station.place}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.star_outline),
                  ),
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.directions),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
