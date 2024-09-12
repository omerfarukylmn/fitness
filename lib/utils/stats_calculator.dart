import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class StatsCalculator {
  static Map<String, double> calculateStats(List<LatLng> points, DateTime startTime) {
    double totalDistance = 0.0;

    if (points.length < 2) return {'totalDistance': totalDistance, 'averageSpeed': 0.0};

    for (int i = 1; i < points.length; i++) {
      totalDistance += Geolocator.distanceBetween(
        points[i - 1].latitude,
        points[i - 1].longitude,
        points[i].latitude,
        points[i].longitude,
      );
    }

    final elapsedTime = DateTime.now().difference(startTime).inSeconds / 3600.0;
    final averageSpeed = totalDistance / 1000.0 / elapsedTime; // Convert to km/h

    return {'totalDistance': totalDistance / 1000.0, 'averageSpeed': averageSpeed}; // Convert to km
  }
}