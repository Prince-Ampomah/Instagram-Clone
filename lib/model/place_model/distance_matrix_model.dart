import 'package:geolocator/geolocator.dart';

class DistanceMaxtrixModel {
  String? originAddress, destinationAddress, distance, duration;
  DistanceMaxtrixModel(
      {this.originAddress,
      this.destinationAddress,
      this.distance,
      this.duration});

  DistanceMaxtrixModel.fromMapObject(Map<String, dynamic> map) {
    originAddress = map['origin_addresses'][0];
    destinationAddress = map['destination_addresses'][0];
    distance = map['rows'][0]['elements'][0]['distance']['text'];
    duration = map['rows'][0]['elements'][0]['duration']['text'];
  }

  double getDistanceOnlyInNum() {
    return double.parse(distance!.replaceAll(RegExp('km'), '').trim());
  }

  static double calculateProximity(
    double sourceLatitude,
    double sourceLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) {
    return Geolocator.distanceBetween(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude,
    );
  }
}
