import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:refuelety/api/api.dart';

final GetIt app = GetIt.instance;

void setup() {
  app.allowReassignment = true;

  // Configure logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    // ignore: avoid_print
    print(
      '${record.time} - ${record.level.name} | '
      '${record.loggerName} => ${record.message}',
    );
  });

  app
    ..registerFactory<FuelService>(OnlineFuelService.new)
    ..registerFactory<GeoService>(OnlineGeoService.new);
}
