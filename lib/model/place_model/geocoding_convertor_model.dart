class FormattedAddressModel {
  String? name;
  String? street;
  String? country;
  String? locality;
  String? subLocality;
  String? administrativeArea;
  String? subAdministrativeArea;
  String? thoroughfare;
  String? subThoroughfare;
  String? postalCode;
  String? isoCountryCode;

  Map<String, dynamic>? gpsCoordinate;

  FormattedAddressModel({
    this.gpsCoordinate,
    this.name,
    this.street,
    this.country,
    this.locality,
    this.subLocality,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.thoroughfare,
    this.subThoroughfare,
    this.postalCode,
    this.isoCountryCode,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['location'] = gpsCoordinate;
    map['locationName'] = name;
    map['street'] = street;
    map['country'] = country;
    map['locality'] = locality;
    map['subLocality'] = subLocality;
    map['region'] = administrativeArea;
    map['subRegion'] = subAdministrativeArea;
    map['thoroughfare'] = thoroughfare;
    map['subThoroughfare'] = subThoroughfare;
    map['postalCode'] = postalCode;
    map['isoCountryCode'] = isoCountryCode;

    return map;
  }

  FormattedAddressModel.fromMapObject(Map<String, dynamic> map) {
    // "gps": {"lat": lat, "long": long},
    //   "locationName": place.name,
    //   "street": place.street,
    //   "country": place.country,
    //   "locality": place.locality,
    //   "subLocatlity": place.subLocality,
    //   "region": place.administrativeArea,
    //   "subRegion": place.subAdministrativeArea,
    //   "thoroughfare": place.thoroughfare,
    //   "subThoroughfare": place.subThoroughfare,
    //   "postalCode": place.postalCode,
    //   "countyCode": place.isoCountryCode,

    gpsCoordinate = map['location'];
    name = map['locationName'];
    street = map['street'];
    country = map['country'];
    locality = map['locality'];
    subLocality = map['subLocality'];
    administrativeArea = map['region'];
    subAdministrativeArea = map['subRegion'];
    thoroughfare = map['thoroughfare'];
    subThoroughfare = map['subThoroughfare'];
    postalCode = map['postalCode'];
    isoCountryCode = map['isoCountryCode'];
  }

  // String getFilteredLocationAddress() {
  //   return '$name $street\n$subLocality';
  //   // return '$subLocality $name\n$thoroughfare';
  // }

  // Map customerAddress() {
  //   return {
  //     'address': '$name $street\n$subLocality',
  //     'lat': gpsCoordinate!['lat'],
  //     'long': gpsCoordinate!['long'],
  //     'country': country,
  //     'state': administrativeArea,
  //   };
  // }

  // LatLng getLatLng() => LatLng(gpsCoordinate!['lat'], gpsCoordinate!['long']);
}

class HumanReadableAddressModel {
  String? placeId;
  Map<String, dynamic>? geometry;
  String? formattedAddress;
  List<dynamic>? addressComponents;
  List<dynamic>? types;

  HumanReadableAddressModel({
    this.placeId,
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.types,
  });

  HumanReadableAddressModel.fromMapObject(Map<String, dynamic> map) {
    placeId = map['place_id'];
    addressComponents = map['address_components'];
    formattedAddress = map['formatted_address'];
    geometry = map['geometry'];
    types = map['types'];
  }
}
