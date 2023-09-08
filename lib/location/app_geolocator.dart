import 'package:geolocator/geolocator.dart';

import '../core/injector.dart';
import '../core/prefs.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
class AppGeolocator{
  final appPref = getIt.get<AppPrefs>();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    final cachedPosition = await appPref.getLocationData();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      if(cachedPosition != null){
        return cachedPosition;
      }

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        if(cachedPosition != null){
          return cachedPosition;
        }
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      if(cachedPosition != null){
        return cachedPosition;
      }

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    appPref.setPosition(position);

    return position;
  }

  Future<Position?> getLastKnownPosition() async{
    return await Geolocator.getLastKnownPosition();
  }
}
