import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();
  PermissionStatus? _permissionGranted;

  Future<LocationData?> getCurrentLocation() async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await _location.requestService();
      if (!result) {
        return null;
      }
    }

    if (await requestLocationPermission()) {
      return null;
    }

    final locationData = await _location.getLocation();
    return locationData;
  }

  Future<bool> requestLocationPermission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }
}
