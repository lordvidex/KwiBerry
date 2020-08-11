import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

//cache fetcher class checks the user devices to see if the user location has
//been stored before and saves the data retrieved
//returns *TRUE* if data exists in cache and *FALSE* when data does not exist

class CacheFetcher extends ChangeNotifier {
  double latitude;
  double longitude;
  LocationData locData;
  String locationDesc;

  Location _location = new Location();

  Future<bool> retrieveLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble("latitude");
    longitude = prefs.getDouble("longitude");
    locationDesc = prefs.getString("locationDesc");
    if (latitude == null || longitude == null) {
      await setLocation();
      return false;
    } else {
      await setLocation();
      return true;
    }
  }

  LocationData get locationData {
    print(locData);
    return locData;
  }

  Future<void> setLocation() async {
    LocationData _data = await _location.getLocation();
    latitude = _data.latitude;
    longitude = _data.longitude;
    locData = _data;
    print(locData);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("latitude", latitude);
    pref.setDouble("longitude", longitude);
    notifyListeners();
  }
}
