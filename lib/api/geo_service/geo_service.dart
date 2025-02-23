import 'package:geolocator/geolocator.dart';

abstract class GeoService {
  Future<bool> checkPermission();
  Future<Position> getPosition();
  Stream<Position> getPositionStream();
  double calculateDistance(Position position, double lat, double lng);
}

class OnlineGeoService implements GeoService {
  @override
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    final bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      //TODO: Ask to enable location services
      return false;
    }
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  @override
  Future<Position> getPosition() async {
    return Geolocator.getCurrentPosition();
  }

  @override
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  @override
  double calculateDistance(Position position, double lat, double lng) {
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      lat,
      lng,
    );
  }
}
