class PlaceDetailsModel {
  String? placeId;
  double? lat, long;
  Map<String, dynamic>? location;
  String? name, formattedAddress;
  PlaceDetailsModel({
    this.placeId,
    this.name,
    this.formattedAddress,
    this.location,
    this.lat,
    this.long,
  });

  PlaceDetailsModel.fromMapObject(Map<String, dynamic> map) {
    placeId = map['place_id'];
    formattedAddress = map['formatted_address'];
    name = map['name'];
    location = map['geometry']['location'];
    lat = map['geometry']['location']['lat'];
    long = map['geometry']['location']['lng'];
  }
}
