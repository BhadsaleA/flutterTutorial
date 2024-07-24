class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

bool areCoordinatesSame(Location loc1, Location loc2, {double tolerance = 0.000001}) {
  return (loc1.latitude - loc2.latitude).abs() < tolerance &&
         (loc1.longitude - loc2.longitude).abs() < tolerance;
}

void main() {
  Location location1 = Location(latitude: 18.5090817, longitude: 73.8302576);
  Location location2 = Location(latitude: 37.4219998, longitude: -122.0840576);
  
  bool isSame = areCoordinatesSame(location1, location2);
  print('Are coordinates the same? $isSame');
}

// latitude: 18.5090716, longitude: 73.8302917