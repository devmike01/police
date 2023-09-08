import 'package:geocoding/geocoding.dart';

import '../latlng.dart';

abstract class LocationState{}
class CurrentLocationState extends LocationState{
  List<Placemark>? placemarks;
  bool noLocation;
  LatLng? latlng;


  CurrentLocationState({this.placemarks, this.latlng, this.noLocation =false});

  factory CurrentLocationState.fromJson(Map<String, dynamic> json){
    return CurrentLocationState(placemarks: [fromPlacemarkToJson(json['placemarks'])],
        latlng: LatLng.fromJson(json['placemarks']),
        noLocation: json['noLocation']);
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json['noLocation'] = noLocation;
    json['placemarks'] = placemarks;
    json['latlng'] = latlng?.toJson();
    return json;
  }

  static Placemark fromPlacemarkToJson(Map<String, dynamic> json){
    return Placemark(
      name: json['name'],
      locality: json['locality'],
      street: json['street']
    );
  }
}
class None extends LocationState{}