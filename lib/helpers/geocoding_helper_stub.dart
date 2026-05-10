class GeocodingHelper {
  static Future<List<PlacemarkStub>> placemarkFromCoordinates(double lat, double lng) async {
    return [];
  }
}

class PlacemarkStub {
  final String? street;
  final String? locality;
  final String? administrativeArea;
  final String? country;

  PlacemarkStub({this.street, this.locality, this.administrativeArea, this.country});
}
