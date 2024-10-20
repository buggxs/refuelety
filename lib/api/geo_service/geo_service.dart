import 'package:geolocator/geolocator.dart';

abstract class GeoService {
  
  Future<Position> getPosition();
  Stream<Position> getPositionStream();
  double calculateDistance(Position position, double lat, double lng);
}

class OnlineGeoService implements GeoService {
  @override
  

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
