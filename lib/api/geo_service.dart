import 'package:geolocator/geolocator.dart';

class GeoService {
  Future<void> checkPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission is denied');
    }
    if (!serviceEnabled) {
      throw Exception('Location service is disabled');
    }
  }

  Future<Position> getPosition() async {
    checkPermission();
    return Geolocator.getCurrentPosition();
  }

  Stream<Position> getPositionStream() {
    checkPermission();
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  double calculateDistance(Position position, double lat, double lng) {
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      lat,
      lng,
    );
  }
}
