import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:police/core/injector.dart';
import 'package:police/location/app_geolocator.dart';

import 'location_state.dart';

class LocationBloc extends Cubit<LocationState>{
  LocationBloc(): super(None());

  void getCurrentLocation() async{
    final geo = getIt.get<AppGeolocator>();
    final position = await geo.determinePosition();
    final placeMarks = await placemarkFromCoordinates(position.latitude,
        position.longitude);
    emit(CurrentLocationState(placeMarks));
  }

}