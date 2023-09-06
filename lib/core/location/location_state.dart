import 'package:geocoding/geocoding.dart';

abstract class LocationState{}
class CurrentLocationState extends LocationState{
  List<Placemark>? placemarks;
  bool noLocation;
  CurrentLocationState({this.placemarks, this.noLocation =false});
}
class None extends LocationState{}