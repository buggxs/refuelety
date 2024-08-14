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
    final LocationPermission permission = await Geolocator.checkPermission();
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied) {
      return false;
    }
    if (!serviceEnabled) {
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
