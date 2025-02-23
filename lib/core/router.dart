import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:refuelety/components/fuel_station/fuel_station_list_screen.dart';
import 'package:refuelety/components/map_view/map_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/map',
  routes: <RouteBase>[
    GoRoute(
      path: '/map',
      name: 'map',
      builder: (BuildContext context, GoRouterState state) => const MapScreen(),
    ),
    GoRoute(
      path: '/stations',
      name: 'stations',
      builder: (BuildContext context, GoRouterState state) =>
          const FuelStationListScreen(),
    ),
  ],
);
