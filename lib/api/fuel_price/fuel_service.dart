import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:refuelety/api/fuel_price/data/fuel_station.dart';
import 'package:refuelety/api/fuel_price/data/fuel_station_page.dart';
import 'package:refuelety/api/fuel_price/data/fuel_type.dart';
import 'package:refuelety/env/env.dart';
import 'package:refuelety/misc/logger.dart';

abstract class FuelService {
  /// Loads the fuel station data from "Tankerkönig API"
  ///
  /// [radius] must be less than 25.
  Future<FuelStationPage<FuelStation>> getFuelStationInRadius({
    required double lat,
    required double lng,
    double radius,
    FuelType type,
    String sort,
  });
}

// 51.25658198622681, 9.778654967099644

class OnlineFuelService with LoggerMixin implements FuelService {
  @override
  Future<FuelStationPage<FuelStation>> getFuelStationInRadius({
    required double lat,
    required double lng,
    double radius = 5.0,
    FuelType type = FuelType.all,
    String sort = 'dist',
  }) {
    assert(radius <= 25.0);
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'lat': lat.toString(),
      'lng': lng.toString(),
      'rad': radius.toString(),
      'sort': sort,
      'type': type.name,
      // TODO: store the apikey somehow secure
      'apikey': Env.tankerKoenigApiKey,
    };
    final Uri url = Uri.https(
      'creativecommons.tankerkoenig.de',
      'json/list.php',
      queryParams,
    );

    log.info(url);

    return http.get(url).then(
          (Response response) => FuelStationPage<FuelStation>.fromJson(
            jsonDecode(response.body),
            FuelStation.fromJson,
          ),
        );
  }
}
