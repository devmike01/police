import 'package:geocoding/geocoding.dart';

import '../latlng.dart';

abstract class LocationState{}
class CurrentLocationState extends LocationState{
  List<Placemark>? placemarks;
  bool noLocation;
  LatLng? latlng;

  CurrentLocationState({this.placemarks, this.latlng, this.noLocation =false});
}
class None extends LocationState{}