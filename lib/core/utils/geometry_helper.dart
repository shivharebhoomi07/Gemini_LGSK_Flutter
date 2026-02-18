import 'dart:math';

class GeometryHelper {
  // Earth's mean radius in meters
  static const double earthRadius = 6371000.0;

  /// Calculates a destination point given a start point, distance (meters), and bearing (degrees).
  /// This is essential for drawing circles or creating orbit paths around a city.
  /// 
  /// [lat]: Latitude of the center point
  /// [lng]: Longitude of the center point
  /// [distance]: Distance from the center in meters
  /// [bearing]: Direction in degrees (0 = North, 90 = East)
  static Map<String, double> calculateDestinationPoint({
    required double lat,
    required double lng,
    required double distance,
    required double bearing,
  }) {
    final double angularDistance = distance / earthRadius;
    final double bearingRadians = _toRadians(bearing);
    final double latRadians = _toRadians(lat);
    final double lngRadians = _toRadians(lng);

    final double destLatRadians = asin(
      sin(latRadians) * cos(angularDistance) +
      cos(latRadians) * sin(angularDistance) * cos(bearingRadians),
    );

    final double destLngRadians = lngRadians +
        atan2(
          sin(bearingRadians) * sin(angularDistance) * cos(latRadians),
          cos(angularDistance) - sin(latRadians) * sin(destLatRadians),
        );

    return {
      'lat': _toDegrees(destLatRadians),
      'lng': _toDegrees(destLngRadians),
    };
  }

  /// Generates a list of coordinates forming a circle around a center point.
  /// Usage: generating a camera path that orbits a building.
  static List<Map<String, double>> generateOrbitPath({
    required double centerLat,
    required double centerLng,
    required double radius, // in meters
    int steps = 36, // number of points (36 = 1 point every 10 degrees)
  }) {
    List<Map<String, double>> path = [];
    
    for (int i = 0; i < steps; i++) {
      double bearing = (360 / steps) * i;
      path.add(calculateDestinationPoint(
        lat: centerLat,
        lng: centerLng,
        distance: radius,
        bearing: bearing,
      ));
    }
    
    return path; // Returns list of {lat, lng} to close the loop
  }

  // -- Helpers --

  static double _toRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  static double _toDegrees(double radians) {
    return radians * (180.0 / pi);
  }
}