import 'package:geocoding/geocoding.dart';

abstract class LocationState{}
class CurrentLocationState extends LocationState{
  List<Placemark> placemarks;
  CurrentLocationState(this.placemarks);
}
class None extends LocationState{}