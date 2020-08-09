import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//cache fetcher class checks the user devices to see if the user location has
//been stored before and saves the data retrieved
//returns *TRUE* if data exists in cache and *FALSE* when data does not exist

class CacheFetcher extends ChangeNotifier {
  double latitude;
  double longitude;
  String locationDesc;
  Future<bool> retrieveLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      latitude = prefs.getDouble("latitude");
      longitude = prefs.getDouble("longitude");
      locationDesc = prefs.getString("locationDesc");
      return true;
    } catch (e) {
      print('CacheFetcher: error retrieving location');
      print(e);
      return false;
    }
  }
}
