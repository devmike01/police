import 'package:police/core/latlng.dart';

abstract class NeibourhoodEvent{}
class GetNeibourhoodEvent extends NeibourhoodEvent{
  LatLng latLng;
  GetNeibourhoodEvent(this.latLng);
}